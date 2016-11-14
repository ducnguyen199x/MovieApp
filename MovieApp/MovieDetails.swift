//
//  MovieDetails.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Gloss

class MovieDetails: Decodable {
  
  let id: String?
  let name: String?
  let duration: Int?
  let description: String?
  let version: String?
  let publishDate: Date?
  let statusID: Int?
  let posterLandscapeURL: String?
  let imdb: Double?
  let actorsList: [String]?
  
  required init?(json: JSON) {
    self.id = "film_id" <~~ json
    self.name = "film_name" <~~ json
    self.duration = "film_duration" <~~ json
    self.description = "film_description_mobile" <~~ json
    self.version = "film_version" <~~ json
    self.statusID = "status_id" <~~ json
    self.posterLandscapeURL = "poster_landscape" <~~ json
    self.imdb = "imdb_point" <~~ json
    
    let dateString: String? = "publish_date" <~~ json
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    self.publishDate = dateFormatter.date(from: dateString!)
    actorsList = []
  }
}
