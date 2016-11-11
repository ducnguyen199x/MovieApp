//
//  NewsCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/8/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: UICollectionViewCell {
  
  @IBOutlet var newsImageView: UIImageView!
  @IBOutlet var newsTitleLabel: UILabel!
  @IBOutlet var publishTimeLabel: UILabel!
  
  // Load news image
  func loadImageView(withUrl url: String?) {
    guard let url = url else { return }
    newsImageView.kf.setImage(with: URL(string: url))
    
  }
  
  // Load title
  func loadTitle(title: String?) {
    guard let title = title else {
      newsTitleLabel.text = "UNKNOWN"
      return
    }
    
    newsTitleLabel.text = title.uppercased()
  }
  
  
  // Load publish time
  func loadPublishTime(publishTime: Date?) {
    guard let publishTime = publishTime else {
      publishTimeLabel.text = "UNKNOWN"
      return
    }
    
  publishTimeLabel.text = timeFromDate(date: publishTime)
  }
  
  // Convert Time Difference
  func timeFromDate(date: Date?) -> String {
    guard let date = date else { return "UNKNOWN" }
    
    let timeDifference = Int(Date().timeIntervalSince(date))
    
    let days = Int(timeDifference / 86400)
    let hours = Int((timeDifference - days * 86400) / 3600)
    let minutes = Int((timeDifference - days * 86400 - hours * 3600) / 60)
    
    if days == 0 {
      return "\(hours)h ago"
    } else if hours == 0 {
      return "\(minutes)m ago"
    } else if minutes == 0 {
      return "Just now"
    } else {
      return "\(days)d ago"
    }
  }
}
