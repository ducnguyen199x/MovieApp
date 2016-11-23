//
//  CategoryCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
  
  @IBOutlet var categoryLabel: UILabel!
  @IBOutlet var collectionView: UICollectionView!
  
  var sessions = [MovieSession]()

}

// MARK: UICollectionViewDataSource
extension CategoryCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return sessions.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
    
    cell.timeLabel.text = sessions[indexPath.row].getShortTime()
    
    return cell
  }
}



