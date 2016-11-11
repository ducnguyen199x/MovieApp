//
//  NewsListViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/8/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import RxSwift

class NewsListViewModel {
  
  // RxSwift
  var newsListObservable: Variable<[News]> = Variable([])
  var newsList: [News] {
    get{
      return newsListObservable.value
    }
    
    set{
      newsListObservable.value = newValue
    }
  }
  
  let defaultSession = URLSession(configuration: .default)
  let api = APIData(version: "2.97", option: .newsList)


  // Fetch Data from API
  func fetchNews() {
    guard let url = URL(string: "\(api.getAPIPath())?type_id=1") else { return }
    
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
          self.updateNewsList(data: data)
        }
      }
    }
    
    task.resume()
  }
  
  // Update Data
  func updateNewsList(data: Data?) {
    newsList.removeAll()
    
    // parse JSON
    do {
      guard let data = data, let response = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String: AnyObject] else { return }
   
      guard let array = response["result"] as? [AnyObject] else { return }
      
      
      // create movie from JSON and append to moviesList
      for i in 0..<array.count {
        if let item = array[i] as? [String: AnyObject], let news = News(json: item) {
          newsList.append(news)
        }
      }
      
    } catch {
      print(error)
    }
  }
  
  // Get News at Index
  func getNews(atIndex index: Int) -> News {
    return newsList[index]
  }
}
