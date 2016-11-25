//
//  CalendarCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/17/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class CalendarCell: UITableViewCell {
  
  @IBOutlet var collectionView: UICollectionView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
  }
}
