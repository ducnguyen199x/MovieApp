//
//  NewsDetails.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/25/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Gloss

class NewsDetails: Decodable {
  let id: String?
  let title: String?
  let description: String?
  let url: String?
  let content: String?
  
  required init?(json: JSON) {
    self.id = "news_id" <~~ json
    self.title = "news_title" <~~ json
    self.description = "news_description" <~~ json
    self.url = "news_url" <~~ json
    self.content = "content" <~~ json
  }
}
