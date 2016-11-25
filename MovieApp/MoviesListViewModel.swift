//
//  MoviesListViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/8/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss
import RxSwift

enum ListType: Int {
  case Upcoming = 1
  case NowShowing
}

class MoviesListViewModel : NSObject {
  
  let type: ListType
  
  let defaultSession = URLSession(configuration: .default)
  let api = APIData(version: "2.97", option: .moviesList)
  
  // Rxswift here
  var moviesListObservable: Variable<[Movie]> = Variable([])
  var moviesList: [Movie] {
    get {
      return self.moviesListObservable.value
    }
    
    set{
      self.moviesListObservable.value = newValue
    }
  }
  
  init(type: ListType) {
    self.type = type
  }
  
  func fetchMovies(completionHandler: (() -> ())?) {
    guard let url = URL(string: "\(api.getAPIPath())?status=\(self.type.rawValue)") else { return }
    
    
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
          self.updateMoviesList(data: data)
          if let completionHandler = completionHandler {
            completionHandler()
          }
        }
      }
    }
    
    task.resume()
  }
  
  func updateMoviesList(data: Data?) {
    moviesList.removeAll()
    
    // parse JSON
    do {
      guard let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else { return }
      
      guard let array = response["result"] as? [AnyObject] else { return }
      
      // create movie from JSON and append to moviesList
      for i in 0..<array.count {
        if let item = array[i] as? [String: AnyObject], let movie = Movie(json: item) {
          moviesList.append(movie)
        }
      }
      
    } catch {
      print(error)
    }
  }
  
  // Get Movie at Index
  func getMovie(atIndex index: Int) -> Movie {
    return moviesList[index]
  }
}
