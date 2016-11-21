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
  let actorsList: [[String: String]]?
  let pgRating: String?
  var schedules = [Schedule]()
  var pCinemaList = [String: Int]()
  
  required init?(json: JSON) {
    self.id = "film_id" <~~ json
    self.name = "film_name" <~~ json
    self.description = "film_description_mobile" <~~ json
    self.version = "film_version" <~~ json
    self.statusID = "status_id" <~~ json
    self.posterLandscapeURL = "poster_landscape" <~~ json
    self.imdb = "imdb_point" <~~ json
    self.actorsList = "list_actor" <~~ json
    self.pgRating = "pg_rating" <~~ json
    
    let durationString: String? = "film_duration" <~~ json
    let duration = Int(durationString!)
    self.duration = duration
    
    let dateString: String? = "publish_date" <~~ json
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    self.publishDate = dateFormatter.date(from: dateString!)
    
  }
  
  // generate String of PublishDate
  func getPublishDateString() -> String {
    guard let date = self.publishDate else { return "UNKNOWN" }
    
    return DateFormatter.localizedString(from: date, dateStyle: .long, timeStyle: .none)
  }
  
  // get director
  func getDirector() -> String {
    var director = ""
    
    guard let actorsList = actorsList else { return director }
    
    for actor in actorsList {
      
      if actor["char_name"]! == "Đạo Diễn" {
        director = actor["artist_name"]!
      }
    }
    
    return director
  }
  
  // get stars
  func getStars() -> String {
    var actorsString = ""
    
    guard let actorsList = actorsList else { return actorsString }
    
    for actor in actorsList {

      if actor["char_name"]! != "Đạo Diễn" {
        if actorsString != "" {
          actorsString.append(", ")
        }
        actorsString.append(actor["artist_name"]!)
      }
    }
    
    return actorsString

  }
  
  // count number of Pcinema
  func filterPCinema() -> Int {
    pCinemaList.removeAll()
    for schedule in schedules {
      guard let name = schedule.pCinemaName else { continue }
      if pCinemaList.keys.contains(name) {
        pCinemaList.updateValue(pCinemaList[name]! + 1, forKey: name)
      } else {
        pCinemaList.updateValue(1, forKey: name)
      }
    }
    
    return pCinemaList.count
  }
}








