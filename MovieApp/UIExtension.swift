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


// Add Border for a label
class CustomBorderedLabel: UILabel {
  @IBInspectable var borderColor: UIColor = UIColor.black
  
  @IBInspectable var top: CGFloat = 0 {
    didSet {
      let border = CALayer()
      border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: top)
      border.backgroundColor = borderColor.cgColor;
      
      self.layer.addSublayer(border)
    }
  }
  
  @IBInspectable var bottom: CGFloat = 0 {
    didSet {
      let border = CALayer()
      border.frame = CGRect(x: 0, y: self.frame.height - bottom, width: self.frame.width, height: bottom)
      border.backgroundColor = borderColor.cgColor;
      
      self.layer.addSublayer(border)
    }
  }
  
  @IBInspectable var left: CGFloat = 0 {
    didSet {
      let border = CALayer()
      border.frame = CGRect(x: 0, y: 0, width: left, height: self.frame.height)
      border.backgroundColor = borderColor.cgColor;
      
      self.layer.addSublayer(border)
    }
  }
  
  @IBInspectable var right: CGFloat = 0 {
    didSet {
      let border = CALayer()
      border.frame = CGRect(x: self.frame.width - right, y: 0, width: right, height: self.frame.height)
      border.backgroundColor = borderColor.cgColor;
      
      self.layer.addSublayer(border)
    }
  }
 }


class BorderedLabel: UILabel {
  @IBInspectable var borderWidth: CGFloat = 0.0 {
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













