//
//  Cinema.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/9/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss
import GoogleMaps

class Cinema: Decodable {
  
  let locationID: String?
  let pCinemaID: Int?
  let pCinemaName: String?
  let id: Int?
  let name: String?
  let address: String?
  let latitude: Double?
  let longtitude: Double?
  let logoURL: String?
  let phone: String?
  let imageURL: String?
  let listPriceURL: String?
  var distance: Double
  
  required init?(json: JSON) {
    self.locationID = "location_id" <~~ json
    self.pCinemaID = "p_cinema_id" <~~ json
    self.pCinemaName = "p_cinema_name" <~~ json
    self.id = "cinema_id" <~~ json
    self.name = "cinema_name" <~~ json
    self.address = "cinema_address" <~~ json
    self.latitude = "cinema_latitude" <~~ json
    self.longtitude = "cinema_longitude" <~~ json
    self.logoURL = "cinema_logo" <~~ json
    self.phone = "cinema_phone" <~~ json
    self.imageURL = "cinema_image" <~~ json
    self.listPriceURL = "list_price" <~~ json
    self.distance = 0
  }
  
  
  // Calculate and return distance from this cinema from a targetLocation
  func getDistance(fromLocation targetLocation: CLLocation) -> Double {
    guard let latitude = self.latitude, let longitude = self.longtitude else { return 0 }
    
    let cinemaLocation = CLLocation(latitude: latitude, longitude: longitude)
    
    let distance = targetLocation.distance(from: cinemaLocation) / 1000
    
    self.distance = distance
    
    return distance
  }
}
