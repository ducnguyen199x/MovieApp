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

  var sessionGroups = [MovieSessionGroup]()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    scheduleTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
  }

}



// MARK: UITableViewDataSource
extension CinemaScheduleCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sessionGroups.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell 
    cell.sessionGroup = sessionGroups[indexPath.row]
    cell.loadCategory()
    cell.collectionView.reloadData()

    return cell
  }
}


// MARK: UITableViewDelegate
extension CinemaScheduleCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let cell = tableView.cellForRow(at: indexPath) as? CategoryCell {

      return cell.collectionView.contentSize.height + 20

    }
    return 100
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}












