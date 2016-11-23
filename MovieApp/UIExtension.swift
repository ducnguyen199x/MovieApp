//
//  UIExtension.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

extension UITableViewCell {  
  
  func addSeparator(color: CGColor, thickness: CGFloat, leftInset: CGFloat, rightInset: CGFloat) {
    let separator = CALayer()
    
    separator.frame = CGRect(x: leftInset, y: self.frame.size.height - thickness, width: UIScreen.main.bounds.width - rightInset, height: thickness)
    separator.backgroundColor = color
    
    self.layer.addSublayer(separator)
  }
}


class BorderedLabel: UILabel {
  @IBInspectable var borderWidth: CGFloat = 0.5 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor = UIColor.white {
    didSet {
      layer.borderColor = borderColor.cgColor
    }
  }
}













