//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
  
  let api = APIData(version: "2.97", option: .movieDetail)
  
  let defaultSession = URLSession(configuration: .default)
  
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
  
}

// MARK: Int extension
extension Int {
  func minutesToHours() -> String {
    let hours = self / 60
    let minutes = self % 60
    
    return "\(hours)h \(minutes)min"
  }
}







