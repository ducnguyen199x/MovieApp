//
//  MoreButton.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/15/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class MoreButton: UIButton {
  
  let buttonTitleColor = UIColor(red: 152/255, green: 152/255, blue: 152/255, alpha: 1)
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    self.setTitle("More", for: .normal)
    self.setTitle("Less", for: .selected)
    self.setTitleColor(buttonTitleColor, for: .normal)
    self.setTitleColor(buttonTitleColor, for: .selected)
  }
}
