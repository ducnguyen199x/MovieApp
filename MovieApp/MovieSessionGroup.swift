//
//  MovieSessionGroup.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/21/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Gloss

class MovieSessionGroup: Decodable {
  let versionID: Int?
  let isVoice: Int?
  var sessions = [MovieSession]()
  
  required init?(json: JSON) {
    self.versionID = "version_id" <~~ json
    self.isVoice = "is_voice" <~~ json
    
    let sessions: [AnyObject]? = "sessions" <~~ json
    guard let sessionsList = sessions else { return }
    
    for i in 0..<sessionsList.count {
      if let item = sessionsList[i] as? [String: AnyObject], let newSession = MovieSession(json: item) {
        self.sessions.append(newSession)
      }
    }
  }
}
