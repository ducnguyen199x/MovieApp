//
//  DayCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/17/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
  
  @IBOutlet var DayOfWeekLabel: UILabel!
  @IBOutlet var DateLabel: UILabel!
  
  let defaultTextColor = UIColor(red: 99/225, green: 99/225, blue: 99/225, alpha: 1)
  let defaultBackgroundColor = UIColor(red: 42/225, green: 42/225, blue: 42/225, alpha: 1)
  let selectedBackgroundColor = UIColor(red: 224/225, green: 50/225, blue: 70/225, alpha: 1)
  let selectedTextColor = UIColor.white
  
  var date: Date?
  let dateFormatter = DateFormatter()
  let calendar = Calendar.current
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        DayOfWeekLabel.backgroundColor = selectedBackgroundColor
        DayOfWeekLabel.textColor = selectedTextColor
        DateLabel.textColor = selectedTextColor
        DateLabel.layer.borderColor = selectedTextColor.cgColor
        
      } else {
        DayOfWeekLabel.backgroundColor = defaultBackgroundColor
        DayOfWeekLabel.textColor = defaultTextColor
        DateLabel.textColor = defaultTextColor
        DateLabel.layer.borderColor = defaultBackgroundColor.cgColor
        
      }
    }
  }
  
  func updateDate() {
    guard let date = date else { return }
    dateFormatter.dateFormat = "EEEE"
    
    // day of week
    let dayOfWeek = dateFormatter.string(from: date)
    let index = dayOfWeek.index(dayOfWeek.startIndex, offsetBy: 3)
    DayOfWeekLabel.text = dateFormatter.string(from: date).substring(to: index)
    
    // actual date
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    DateLabel.text = "\(day)/\(month)"
  }
  
  func getShortDate() -> String {
    guard let date = date else { return ""}
    
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: date)
  }
}








