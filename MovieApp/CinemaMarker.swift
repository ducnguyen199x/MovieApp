//
//  CinemaMarker.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/10/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import GoogleMaps

class CinemaMarker: GMSMarker {
  
  let cinema: Cinema
  
  init(cinema: Cinema) {
    self.cinema = cinema
    super.init()
    
    guard let latitude = cinema.latitude, let longtitude = cinema.longtitude else { return }
    
    position = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    icon = UIImage(named: "cinema_around")
    appearAnimation = kGMSMarkerAnimationPop
   
  }
}
