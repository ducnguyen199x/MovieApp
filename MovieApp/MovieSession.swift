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
    self.statusID = "status_id" <~~ json
    
    let dateString: String? = "session_time" <~~ json
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    self.time = dateFormatter.date(from: dateString!)
  }
}
