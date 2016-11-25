//
//  Schedule.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss

enum MovieVersion: Int {
  case twoDimention = 2
  case threeDimention
  
  func description() -> String {
    switch self {
    case .twoDimention:
      return "2D"
    case .threeDimention:
      return "3D"
    }
  }
}

enum MovieVoice: Int {
  case dub = 0
  case sub
  
  func description() -> String {
    switch self {
    case .dub:
      return " Dub"
    case .sub:
      return ""
    }
  }
}

class Schedule: Decodable {
  let cinemaName: String?
  let pCinemaName: String?
  let pCinemaId: Int?
  var sessionGroups = [MovieSessionGroup]()
  
  required init?(json: JSON) {
    self.cinemaName = "cinema_name" <~~ json
    self.pCinemaId = "p_cinema_id" <~~ json
    self.pCinemaName = "p_cinema_name" <~~ json
    
    let groupSession: [AnyObject]? = "group_sessions" <~~ json
    guard let group = groupSession else { return }
    
    for i in 0..<group.count {
      if let item = group[i] as? [String: AnyObject], let newGroup = MovieSessionGroup(json: item) {
        sessionGroups.append(newGroup)
      }
    }
    
  }
  
}
