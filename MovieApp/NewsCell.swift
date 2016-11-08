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
  
  
  func loadImageView(withUrl url: String?) {
    guard let url = url else { return }
    newsImageView.kf.setImage(with: URL(string: url))
  }
}
