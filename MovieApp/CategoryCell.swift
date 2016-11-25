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
  
  var sessionGroup: MovieSessionGroup?

  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
  }
  
  func loadCategory() {
    guard let sessionGroup = sessionGroup,
      let versionID = sessionGroup.versionID,
      let isVoice = sessionGroup.isVoice else {
        return
    }
    
    categoryLabel.text = versionID.description() + isVoice.description()
  }
}

// MARK: UICollectionViewDataSource
extension CategoryCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let sessionGroup = sessionGroup else { return 0 }
    return sessionGroup.sessions.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
    guard let sessionGroup = sessionGroup else { return cell }
    
    cell.session = sessionGroup.sessions[indexPath.row]
    cell.loadSession()
    
    return cell
  }
}



