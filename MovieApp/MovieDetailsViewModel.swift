//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {
  
  let api = APIData(version: "2.97", option: .movieDetail)
  let apiTrailer = APIData(version: "2.97", option: .movieTrailer)
  let apiMovieSchedule = APIData(version: "2.97", option: .scheduleByMovie)
  
  let defaultSession = URLSession(configuration: .default)
  let separatorColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
  
  func fetchMovieDetails(id: String?, completionHandler: @escaping (MovieDetails?) -> ()) {
    guard let id = id else {
      print("Movie Id is empty")
      return
    }
    
    guard let url = URL(string: "\(api.getAPIPath())?film_id=\(id)") else { return }
    
    // Create request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("3", forHTTPHeaderField: "x-123f-version")
    request.addValue(api.getToken(), forHTTPHeaderField: "x-123f-token")
    
    // URLSession
    let task = defaultSession.dataTask(with: request) {
      (data, response, error) in
      
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          DispatchQueue.main.async {
            completionHandler(self.getMovieDetailsFromData(data: data))
          }
        }
      }
    }
    
    task.resume()
  }
  
  // Get trailer url
  func fetchMovieTrailer(id: String?, completionHandler: @escaping ([String: String]?) -> ()) {
    guard let id = id else {
      print("Movie Id is empty")
      return
    }
    
    guard let url = URL(string: "\(apiTrailer.getAPIPath())?film_id=\(id)") else { return }
    
    // Create request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("3", forHTTPHeaderField: "x-123f-version")
    request.addValue(api.getToken(), forHTTPHeaderField: "x-123f-token")
    
    // URLSession
    let task = defaultSession.dataTask(with: request) {
      (data, response, error) in
      
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          DispatchQueue.main.async {
            completionHandler(self.getMovieTrailerURLFromData(data: data))
          }
        }
      }
    }
    
    task.resume()
  }
  
  func getMovieTrailerURLFromData(data: Data?) -> [String: String]? {
    guard let data = data else { return nil }
    
    do {
      if let response = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as? [String: AnyObject] {
        
        guard let movieTrailers = response["result"] as? [String: String] else { return nil }
        
        return movieTrailers
        
      }
    } catch {
      print(error)
    }
    
    return nil
  }
  
  // convert data to MovieDetails object
  func getMovieDetailsFromData(data: Data?) -> MovieDetails? {
    guard let data = data else { return nil }
    
    do {
      if let response = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as? [String: AnyObject] {
        
        guard let movieDetails = response["result"] as? [String: AnyObject] else { return nil }
      
        return MovieDetails(json: movieDetails)
        
      }
    } catch {
      print(error)
    }
    
    return nil
  }
  
//  // Get schedule by movie
//  func fetchScheduleByMovie(id: String?, date: String?, completionHandler: @escaping ([String: AnyObject]?) -> ()) {
//    guard let id = id, let date = date else {
//      print("Movie Id is empty")
//      return
//    }
//    
//    guard let url = URL(string: "\(apiMovieSchedule.getAPIPath())?film_id=\(id)&date=\(date)") else { return }
//    
//    // Create request
//    var request = URLRequest(url: url)
//    request.httpMethod = "GET"
//    request.addValue("3", forHTTPHeaderField: "x-123f-version")
//    request.addValue(api.getToken(), forHTTPHeaderField: "x-123f-token")
//    
//    // URLSession
//    let task = defaultSession.dataTask(with: request) {
//      (data, response, error) in
//      
//      if let error = error {
//        print(error)
//      } else if let httpResponse = response as? HTTPURLResponse {
//        if httpResponse.statusCode == 200 {
//          DispatchQueue.main.async {
//            completionHandler(self.getScheduleByMovieFromData(data: data))
//          }
//        }
//      }
//    }
//    
//    task.resume()
//  }
//  
//  func getScheduleByMovieFromData(data: Data?) -> [String: AnyObject]? {
//    guard let data = data else { return nil }
//    
//    do {
//      if let response = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)) as? [String: AnyObject] {
//        
//        guard let listSession = response["result"] as? [String: AnyObject] else { return nil }
//        
//        guard let 
//        
//        return movieTrailers
//        
//      }
//    } catch {
//      print(error)
//    }
//    
//    return nil
//  }
}



extension MovieDetailsViewModel {
  func cellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
    let identifiers = ["ThumbnailCell", "MovieTitleCell", "MovieSummaryCell", "CalendarCell", "CinemaScheduleCell", "ScheduleCell"]
    
    if indexPath.row >= identifiers.count - 1 && indexPath.row % 2 == 0 {
      return "CinemaScheduleCell"
    } else if indexPath.row >= identifiers.count - 1 && indexPath.row % 2 != 0 {
      return "ScheduleCell"
    } else {
      return identifiers[indexPath.row]
    }
  }
}

// MARK: Int extension
extension Int {
  func minutesToHours() -> String {
    let hours = self / 60
    let minutes = self % 60
    
    return "\(hours)h \(minutes)min"
  }
}







