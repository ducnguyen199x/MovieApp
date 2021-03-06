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
  var schedules = [Schedule]()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    tableView.register(UINib(nibName: "CinemaScheduleCell", bundle: nil), forCellReuseIdentifier: "CinemaScheduleCell")
  }
}

// MARK: UITableViewDataSource
extension ScheduleCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return schedules.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CinemaScheduleCell", for: indexPath) as! CinemaScheduleCell
    cell.cinemaNameLabel.text = schedules[indexPath.row].cinemaName
    cell.sessionGroups = schedules[indexPath.row].sessionGroups
    cell.scheduleTableView.reloadData()
    DispatchQueue.main.async {
      cell.scheduleTableView.reloadData()
    }

    return cell
  }
}

// MARK: UITableViewDelegate
extension ScheduleCell: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let cell = tableView.cellForRow(at: indexPath)
    if let cinemaScheduleCell = cell as? CinemaScheduleCell {
      return cinemaScheduleCell.scheduleTableView.contentSize.height + 50
    }
    return 400
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 400
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}








