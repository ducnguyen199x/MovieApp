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
  
  // Fetch all cinemas
  func fetchCinemas(completionHandler: @escaping ([Cinema]) -> ()) {
    guard let url = URL(string: api.getAPIPath()) else { return }
    
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
          DispatchQueue.main.async {
            completionHandler(self.updateCinemasList(data: data))
          }
        }
      }
    }
    
    task.resume()
  }
  
  // Parse json into Object
  func updateCinemasList(data: Data?) -> [Cinema] {
    cinemasList.removeAll()
    
    do {
      if let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] {
        
        guard let array = response["result"] as? [AnyObject] else { return cinemasList }
      
        for i in 0..<array.count {
          if let item = array[i] as? [String: AnyObject], let cinema = Cinema(json: item) {
            cinemasList.append(cinema)
          }
        }
      }
      
    } catch {
      print(error)
    }
    
    return cinemasList
  }
  
  // find nearby cinemas
  func findNearbyCinemas(atLocation location: CLLocation) {
    nearbyCinemasList = cinemasList.sorted { (cinema1, cinema2) -> Bool in
      cinema1.getDistance(fromLocation: location) < cinema2.getDistance(fromLocation: location)
    }
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
      guard let overview_polyline = routes[0]["overview_polyline"] as? [String: String] else { return polyline }
      
      let path = GMSPath(fromEncodedPath: overview_polyline["points"]!)
      
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














