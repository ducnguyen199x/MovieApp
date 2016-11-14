//
//  CinemaAroundViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/9/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import GoogleMaps
import RxSwift
import RxCocoa


class CinemaAroundViewController: UIViewController {
  
  @IBOutlet var mapView: GMSMapView!
  @IBOutlet var tableView: UITableView!
  
  let cinemaAroundViewModel = CinemaAroundViewModel()
  let locationManager = CLLocationManager()
  var currentLocation = CLLocation()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    mapView.animate(toZoom: 13)
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    
    // Observe data and update UI
    cinemaAroundViewModel.nearbyCinemasListObservable.asObservable().subscribe(onNext: {
      (nearbyCinemas) in
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
      
      }, onError: nil, onCompleted: nil, onDisposed: nil)
      .addDisposableTo(disposeBag)
    
    cinemaAroundViewModel.fetchCinemas {
      (cinemasList) in
      
      for cinema in cinemasList {
        let marker = CinemaMarker(cinema: cinema)
        marker.map = self.mapView
      }
      
      self.locationManager.startUpdatingLocation()
    }
  }
  
  // update location and nearby cinemas when view is shown
  override func viewDidAppear(_ animated: Bool) {
    locationManager.startUpdatingLocation()
   
  }
}

// MARK: UITableViewDataSource
extension CinemaAroundViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cinemaAroundViewModel.nearbyCinemasList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cinemaCell", for: indexPath) as! CinemaCell
    
    cell.nameLabel.text = cinemaAroundViewModel.nearbyCinemasList[indexPath.row].name
    cell.addressLabel.text = cinemaAroundViewModel.nearbyCinemasList[indexPath.row].address
    
    let distance = cinemaAroundViewModel.nearbyCinemasList[indexPath.row].distance
    cell.distanceLabel.text = String(format: "%.1f", distance)
    
    return cell
  }
}

// MARK: UITableViewDelegate
extension CinemaAroundViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cinema = cinemaAroundViewModel.nearbyCinemasList[indexPath.row]
    
    // Move camera to selected cinema
    self.mapView.animate(to: GMSCameraPosition(target: CLLocationCoordinate2D(latitude: cinema.latitude!, longitude: cinema.longtitude!), zoom: 15, bearing: 0, viewingAngle: 0))
    
    // Get direction from Google Map api
    cinemaAroundViewModel.fetchDirection(from: (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude), to: (cinema.latitude!, cinema.longtitude!), completionHandler: {
      (polyline) in
      
      // draw direction
      polyline.map = self.mapView
      
    })
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}

// MARK: CLLocationManagerDelegate
extension CinemaAroundViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      
      locationManager.startUpdatingLocation()
      
      mapView.isMyLocationEnabled = true
      mapView.settings.myLocationButton = true
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      
      mapView.animate(toLocation: location.coordinate)
      
      locationManager.stopUpdatingLocation()
    }
    
    // Detect user location and find nearby cinemas
    if let userLocation = locations.last {
      currentLocation = userLocation
      
      let latitude = userLocation.coordinate.latitude
      let longitude = userLocation.coordinate.longitude
      
      let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
      
      marker.icon = UIImage(named: "current_location")
      
      marker.map = self.mapView
      
      cinemaAroundViewModel.findNearbyCinemas(atLocation: userLocation)
    }
  }
}

// MARK: GMSMapViewDelegate
extension CinemaAroundViewController: GMSMapViewDelegate {
  func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
    if let marker = marker as? CinemaMarker {
    
      guard let infoView = cinemaAroundViewModel.viewFromNibName("CinemaMarkerInfoView") as? CinemaMarkerInfoView else { return nil }
      
      infoView.cinemaName.text = marker.cinema.name
      infoView.cinemaAddress.text = marker.cinema.address
      infoView.icon.image = UIImage(named: "cinema_holder")
      
      mapView.animate(toZoom: 15)
      
      // Get direction from Google Map api
      cinemaAroundViewModel.fetchDirection(from: (currentLocation.coordinate.latitude, currentLocation.coordinate.longitude), to: (marker.cinema.latitude!, marker.cinema.longtitude!), completionHandler: {
          (polyline) in
          
        // draw direction
        polyline.map = self.mapView
        
      })
        
      return infoView
    }
    
    return nil
  }


  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    return false
  }
}






















