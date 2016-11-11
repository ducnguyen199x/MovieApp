//
//  CinemaAroundViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/9/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import RxSwift
import GoogleMaps

class CinemaAroundViewModel {
  
  // declare constant
  let directionURL = "https://maps.googleapis.com/maps/api/directions/json"
  let googleMapsApiKey = "AIzaSyCuImoIQbsgLBEWiGogKx63siPvzq77GqA"
  let polylineColor = UIColor.red
  let polylineWidth: CGFloat = 4.0
  
  let defaultSession = URLSession(configuration: .default)
  let api =  APIData(version: "2.97", option: .cinemas)
  
  var cinemasList: [Cinema] = []
  var polylinesList: [GMSPolyline] = []
  
  // RxSwift
  var nearbyCinemasListObservable: Variable<[Cinema]> = Variable([])
  var nearbyCinemasList: [Cinema] {
    get {
      return nearbyCinemasListObservable.value
    }
    
    set {
      nearbyCinemasListObservable.value = newValue
    }
  }
  
  init() {
    fetchCinemas(withURL: api.getAPIPath())
  }
  
  // Fetch all cinemas
  func fetchCinemas(withURL url: String) {
    guard let url = URL(string: url) else { return }
    
    // Create request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("3", forHTTPHeaderField: "x-123f-version")
    request.addValue(api.getToken(), forHTTPHeaderField: "x-123f-token")
    
    //URLSession
    let task = defaultSession.dataTask(with: request) {
      (data, response, error) in
      
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          self.updateCinemasList(data: data)
        }
      }
    }
    
    task.resume()
  }
  
  // Parse json into Object
  func updateCinemasList(data: Data?) {
    cinemasList.removeAll()
    
    do {
      if let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] {
        
        guard let array = response["result"] as? [AnyObject] else { return }
      
        for i in 0..<array.count {
          if let item = array[i] as? [String: AnyObject], let cinema = Cinema(json: item) {
            cinemasList.append(cinema)
          }
        }
      }
      
    } catch {
      print(error)
    }
  }
  
  // find nearby cinemas
  func findNearbyCinemas(atLocation location: CLLocation) {
    nearbyCinemasList = cinemasList.sorted { (cinema1, cinema2) -> Bool in
      cinema1.getDistance(fromLocation: location) < cinema2.getDistance(fromLocation: location)
    }
    
    // Only get cinemas with distance < 10km
    nearbyCinemasList = nearbyCinemasList.filter { $0.distance < 20 }
  }
  
  // Get Map Direction
  func fetchDirection(from origin: (Double, Double), to destination: (Double, Double), completionHandler: @escaping (GMSPolyline) -> ()) {
    guard let url = URL(string: "\(directionURL)?origin=\(origin.0),\(origin.1)&destination=\(destination.0),\(destination.1)")
      else {
        return
    }
    
    print(url.absoluteString)
    let task = defaultSession.dataTask(with: url) {
      (data, response, error) in
      
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          
          DispatchQueue.main.async {
             completionHandler(self.getDirection(data: data))
          }
        }
      }
    }
    
    task.resume()
  }
  
  // update Direction list
  func getDirection(data: Data?) -> GMSPolyline {
    
    // Clear all directions on the map
    clearAllPolylines()
    
    polylinesList.removeAll()
    
    let polyline = GMSPolyline()
    
    guard let data = data else { return polyline }
    
    do{
      guard let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject? else { return polyline }
      
      guard let routes = response["routes"] as? [AnyObject] else { return polyline }
      guard let legs = routes[0]["legs"] as? [AnyObject] else { return polyline }
      guard let steps = legs[0]["steps"] as? [AnyObject] else { return polyline }
      
      let path = GMSMutablePath()
      
      for i in 0..<steps.count {
        guard let step = steps[i]["start_location"] as? [String: Double] else { return polyline }
        path.addLatitude(step["lat"]!, longitude: step["lng"]!)
        
        if i == steps.count - 1 {
          guard let step = steps[i]["end_location"] as? [String: Double] else { return polyline }
          path.addLatitude(step["lat"]!, longitude: step["lng"]!)
        }
      }
      
      polyline.path = path
      polyline.strokeColor = polylineColor
      polyline.strokeWidth = polylineWidth
      polylinesList.append(polyline)
      
    } catch {
      print(error)
    }
    
    return polyline
  }
  
  // load View from nib
  func viewFromNibName(_ name: String) -> UIView? {
    let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
    return views?.first as? UIView
  }
  
  // clear all polylines
  func clearAllPolylines(){
    for polyline in polylinesList {
      polyline.map = nil
    }
  }
}














