//
//  MovieSession.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss

class MovieSession: Decodable {
  let id: Int?
  let time: Date?
  let statusID: Int?
  

  required init?(json: JSON) {
    self.id = "session_id" <~~ json
    self.time = "session_time" <~~ json
    self.statusID = "status_id" <~~ json
  }
}
