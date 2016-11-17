//
//  MovieSummaryCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/17/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

protocol MovieSummaryCellDelegate {
  func didClickMoreButton()
}

class MovieSummaryCell: UITableViewCell {
  
  
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var directorLabel: UILabel!
  @IBOutlet var writersLabel: UILabel!
  @IBOutlet var starsLabel: UILabel!
  
  var delegate: MovieSummaryCellDelegate?
  
  // show more and show less movie description
  @IBAction func moreButtonClicked(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    if sender.isSelected {
      self.descriptionLabel.numberOfLines = 0
      self.descriptionLabel.lineBreakMode = .byWordWrapping
    } else {
      self.descriptionLabel.numberOfLines = 3
      self.descriptionLabel.lineBreakMode = .byTruncatingTail
    }
    self.descriptionLabel.sizeToFit()
    delegate?.didClickMoreButton()
  }
  
}
