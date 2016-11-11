//
//  Movie.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/7/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss

class Movie: Decodable {
  
  let id: Int?
  let name: String?
  let imdb: Double?
  let posterURL: String?
  let description: String?
  let status: ListType?
  let publishDate: Date?
  
  // MARK: - Deserialization
  required init?(json: JSON) {
    self.id = "film_id" <~~ json
    self.name = "film_name" <~~ json
    self.imdb = "imdb_point" <~~ json
    self.posterURL = "poster_landscape" <~~ json
    self.description = "film_description_mobile" <~~ json
    self.status = "status_id" <~~ json
   
    let dateString: String? = "publish_date" <~~ json
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    self.publishDate = dateFormatter.date(from: dateString!)
  }
  
}
