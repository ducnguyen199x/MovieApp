//
//  ScheduleCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/17/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
  
  @IBOutlet var cinemaNameLabel: UILabel!
  @IBOutlet var scheduleTableView: UITableView!
  
  
  var height: CGFloat = 0
  
  func toggle() {
    if height == 0 {
      height = 360
    } else {
      height = 0
    }
  }
}

// MARK: UITableViewDataSource
extension ScheduleCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
    cell.collectionView.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")
    cell.collectionView.dataSource = self
    
    return cell
  }
}

// MARK: UITableViewDelegate
extension ScheduleCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}

// MARK: UITableViewDelegate
extension ScheduleCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimeCell", for: indexPath) as! TimeCell
    
    return cell
  }
}










