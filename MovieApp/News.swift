//
//  News.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/8/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss

class News: Decodable {
  let id: String?
  let title: String?
  let description: String?
  let url: String?
  let dateAdd: Date?
  let dateUpdate: Date?
  let image_url: String?
  
  required init?(json: JSON) {
    self.id = "news_id" <~~ json
    self.title = "news_title" <~~ json
    self.description = "news_description" <~~ json
    self.url = "url" <~~ json
    
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    var dateString: String? = "date_add" <~~ json
    self.dateAdd = dateFormatter.date(from: dateString!)
    
    dateString = "date_update" <~~ json
    self.dateUpdate = dateFormatter.date(from: dateString!)

    self.image_url = "image_full" <~~ json
    
  }
}
