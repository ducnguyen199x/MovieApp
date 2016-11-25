//
//  TimeCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class TimeCell: UICollectionViewCell {
  
  @IBOutlet var timeLabel: BorderedLabel!
  
  let unAvailabelColor = UIColor(red: 99/225, green: 99/225, blue: 99/225, alpha: 1)
  let availabelColor = UIColor.white
  
  var available = true {
    didSet {
      if available{
        timeLabel.borderColor = availabelColor
        timeLabel.textColor = availabelColor
      } else {
        timeLabel.borderColor = unAvailabelColor
        timeLabel.textColor = unAvailabelColor
      }
    }
  }
  
  var session: MovieSession?
  
  func loadSession() {
    guard let session = session else { return }
    
    let time = session.getShortTime()
    if session.statusID == 1 {
      timeLabel.text = time
      available = true
    } else if session.statusID == 3 {
      timeLabel.text = time
      available = false
    }
  }
  
}
