//
//  NewsDetailsViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/25/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

class NewsDetailsViewModel {
  let defaultSession = URLSession(configuration: .default)
  let api = APIData(version: "2.97", option: .newsDetail)
  
  
  // Fetch Data from API
  func fetchNews(id: String?, completionHandler: @escaping (NewsDetails?) -> ()) {
    guard let id = id else { return }
    guard let url = URL(string: "\(api.getAPIPath())?news_id=\(id)") else { return }
  
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
          completionHandler(self.getNewsDetails(FromData: data))
        }
      }
    }
    
    task.resume()
  }
  
  // Convert Data to Json
  func getNewsDetails(FromData data: Data?) -> NewsDetails? {
    
    // parse JSON
    do {
      guard let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else { return nil }
      
      guard let result = response["result"] as? [String: AnyObject] else { return nil }
      // Create newsDetails and return
      if let news = NewsDetails(json: result) {
        return news
      }
      
    } catch {
      print(error)
    }
    return nil
  } 
}
