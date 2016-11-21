//
//  ScheduleCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/21/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
  
  @IBOutlet var tableView: UITableView!
 
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaScheduleCell", for: indexPath) as! CinemaScheduleCell
    cell.scheduleTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
    cell.scheduleTableView.dataSource = cell
    cell.scheduleTableView.reloadData()
    
    return cell
  }
}
