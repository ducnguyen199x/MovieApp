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
  let calendar = Calendar.current

  required init?(json: JSON) {
    self.id = "session_id" <~~ json
    self.statusID = "status_id" <~~ json
    
    let dateString: String? = "session_time" <~~ json
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    self.time = dateFormatter.date(from: dateString!)
  }
  
 
  // get string time with hour and minute
  func getShortTime() -> String {
    guard let time = time else { return "00:00" }
    
    let hour = calendar.component(.hour, from: time)
    let minute = calendar.component(.minute, from: time)
    
    return "\(hour):" + String(format: "%02d", minute)
  }
}
