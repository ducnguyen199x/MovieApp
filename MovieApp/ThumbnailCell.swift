//
//  ThumbnailCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/16/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher

protocol ThumbnailCellDelegate {
  func playVideo()
}

class ThumbnailCell: UITableViewCell {
  
  let movieTrailers: [String: String]? = nil
  var delegate: ThumbnailCellDelegate? = nil
  
  @IBOutlet var thumbnail: UIImageView!
  
  // Play trailer
  @IBAction func playButtonClicked(_ sender: Any) {
    delegate?.playVideo()
  }
  
  // Load thumbnail
  func loadThumbnail(url: String?) {
    guard let url = url else { return }
    
    thumbnail.kf.setImage(with: URL(string: url))
  }
}
