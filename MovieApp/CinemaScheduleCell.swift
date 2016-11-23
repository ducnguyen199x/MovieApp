//
//  ScheduleCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/17/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class CinemaScheduleCell: UITableViewCell {
  
  @IBOutlet var cinemaNameLabel: UILabel!
  @IBOutlet var scheduleTableView: UITableView!

  var sessionGroup = [MovieSessionGroup]()
  
}

// MARK: UITableViewDataSource
extension CinemaScheduleCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sessionGroup.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
    cell.collectionView.register(UINib(nibName: "TimeCell", bundle: nil), forCellWithReuseIdentifier: "TimeCell")    
    cell.categoryLabel.text = "\(sessionGroup[indexPath.row].versionID!)"
    cell.sessions = sessionGroup[indexPath.row].sessions
    cell.collectionView.dataSource = cell
    cell.collectionView.reloadData()
    
    return cell
  }
}


// MARK: UITableViewDelegate
extension CinemaScheduleCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let cell = tableView.cellForRow(at: indexPath) as? CategoryCell {
      print(cell.collectionView.contentSize.height)
      return cell.collectionView.contentSize.height + 20
      
    }
    return 200
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}












