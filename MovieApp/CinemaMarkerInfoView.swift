//
//  CinemaMarkerInfoView.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/10/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class CinemaMarkerInfoView: UIView {
  
  @IBOutlet var icon: UIImageView!
  @IBOutlet var cinemaName: UILabel!
  @IBOutlet var cinemaAddress: UILabel!
  
  func loadIcon(withURL url: String?) {
    guard let url = url else { return }
    
    icon.kf.setImage(with: URL(string: url))
  }
}
