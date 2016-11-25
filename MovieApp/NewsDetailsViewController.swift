//
//  NewsDetailsViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/25/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class NewsDetailsViewController: UIViewController {
  
  @IBOutlet var webView: UIWebView!
  
  let newsDetailsViewModel = NewsDetailsViewModel()
  var newsID: String?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up navigation bar
    navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav_background"), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.tintColor = UIColor.white
    
    // Back Button
    navigationItem.hidesBackButton = true
    let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(self.back))
    navigationItem.leftBarButtonItem = backButton
    
    // Get news content
    if let newsID = newsID {
      newsDetailsViewModel.fetchNews(id: newsID, completionHandler: {
        (newsDetails) in
        
        guard let newsDetails = newsDetails,
          let content = newsDetails.content
          else { return }
        
        self.webView.loadHTMLString(content, baseURL: nil)
      })
    }

  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)
    
    navigationController?.navigationBar.isHidden = false
  }
  
  func back() {
    _ = navigationController?.popViewController(animated: true)
  }
}
