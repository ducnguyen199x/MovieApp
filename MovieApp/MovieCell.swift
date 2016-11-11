//
//  ShowingCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/7/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher


class MovieCell: UICollectionViewCell {
  let imdbPointColor = UIColor(red: 225/255, green: 40/255, blue: 54/255, alpha: 1)
  let imdbPointFont = UIFont.boldSystemFont(ofSize: 12)
  var movieType: ListType? {
    didSet{
      calendarView.isHidden = movieType?.rawValue == 1 ? true : false
    }
  }
  
  @IBOutlet var movieImage: UIImageView!
  @IBOutlet var movieIMDBLabel: UILabel!
  @IBOutlet var calendarLabel: UILabel!
  @IBOutlet var calendarView: UIView!
  
  
  // Load Image from URL
  func loadImage(url: String?) {
    guard let url = url else { return }
    movieImage.kf.setImage(with: URL(string: url))
  }
  
  // Load imdb point
  func loadIMDBPoint(imdb: Double?) {
    guard let imdb = imdb else { return }
    
    let imdbString = String(format: "%.1f", imdb)
    let imdbAttributedString = NSMutableAttributedString(string: imdbString, attributes: [NSForegroundColorAttributeName: imdbPointColor, NSFontAttributeName: imdbPointFont])
    let labelText = NSAttributedString(string: " IMDB", attributes: [NSForegroundColorAttributeName: UIColor.white])
    imdbAttributedString.append(labelText)
    
    movieIMDBLabel.attributedText = imdbAttributedString
    
    movieIMDBLabel.backgroundColor = UIColor(white: 0, alpha: 0.8)
  }
  
  // Load calendar
  func loadCalendar(date: Date?) {
    guard let date = date else { return }
    
    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    
    calendarLabel.text = "\(day).\(month)"

  }
}








