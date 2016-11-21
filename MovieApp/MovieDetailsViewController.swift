//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit
import AVFoundation
import FLEX

class MovieDetailsViewController: UIViewController {
  

  @IBOutlet var tableview: UITableView!
  
  let movieDetailsViewModel = MovieDetailsViewModel()
  var movieID: String?
  var today: Date?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up navigation bar
    navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav_background"), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.tintColor = UIColor.white
    
    // Back Button
    navigationItem.hidesBackButton = true
    let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(self.back))
    navigationItem.leftBarButtonItem = backButton
    
    // tableview
    tableview.setNeedsLayout()
    
    // Register cell from nib
    tableview.register(UINib(nibName: "ThumbnailCell", bundle: nil), forCellReuseIdentifier: "ThumbnailCell")
    tableview.register(UINib(nibName: "MovieTitleCell", bundle: nil), forCellReuseIdentifier: "MovieTitleCell")
    tableview.register(UINib(nibName: "MovieSummaryCell", bundle: nil), forCellReuseIdentifier: "MovieSummaryCell")
    tableview.register(UINib(nibName: "CalendarCell", bundle: nil), forCellReuseIdentifier: "CalendarCell")
    tableview.register(UINib(nibName: "CinemaGroupCell", bundle: nil), forCellReuseIdentifier: "CinemaGroupCell")
    tableview.register(UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
    FLEXManager.shared().showExplorer()
    
    loadData()

  }
  
  // View did appear
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = false

  }
  
  func back() {
    _ = navigationController?.popViewController(animated: true)
  }
  
  func loadData() {
    movieDetailsViewModel.fetchMovieDetails(id: movieID) {
      (movieDetails) in
      
      self.today = Date()
      
      self.tableview.reloadData()
      
    }
  }
  
 
}

// MARK: UITableViewDataSource
extension MovieDetailsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var numberOfRows = 4
    
    // add row base on number of cinema group (2 rows per group: 1 for group name, 1 for schedule)
    if let movieDetails = movieDetailsViewModel.movieDetails {
      numberOfRows += movieDetails.filterPCinema() * 2
    }

    return numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = movieDetailsViewModel.cellIdentifierAtIndexPath(indexPath: indexPath)
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    guard let movieDetails = movieDetailsViewModel.movieDetails else { return cell }
    
    var cinemaGroup = Array((movieDetailsViewModel.movieDetails?.pCinemaList.keys)!)
    
    // load data for specific cell
    if let thumbnailCell = cell as? ThumbnailCell {
      thumbnailCell.loadThumbnail(url: movieDetails.posterLandscapeURL)
      thumbnailCell.delegate = self
      
    } else if let movieTitleCell = cell as? MovieTitleCell {
      movieTitleCell.titleLabel.text = movieDetails.name
      movieTitleCell.durationLabel.text = movieDetails.duration?.minutesToHours()
      movieTitleCell.pgRatingLabel.text = movieDetails.pgRating
      movieTitleCell.imdbPointLabel.text = "\(movieDetails.imdb!) IMDB"
      movieTitleCell.publishDateLabel.text = movieDetails.getPublishDateString()
      movieTitleCell.addSeparator(color: movieDetailsViewModel.separatorColor.cgColor, thickness: 0.5, leftInset: 20, rightInset: 20)
  
    } else if let movieSummaryCell = cell as? MovieSummaryCell {
      movieSummaryCell.delegate = self
      movieSummaryCell.descriptionLabel.text = movieDetails.description
      movieSummaryCell.directorLabel.text = movieDetails.getDirector()
      movieSummaryCell.starsLabel.text = movieDetails.getStars()

      
    } else if let calendarCell = cell as? CalendarCell {
      calendarCell.collectionView.register(UINib(nibName: "DayCell", bundle: nil), forCellWithReuseIdentifier: "DayCell")
      calendarCell.collectionView.delegate = self
      calendarCell.collectionView.dataSource = self
      calendarCell.collectionView.selectItem(at: IndexPath(row: 0, section: 0) , animated: true, scrollPosition: .left)
      
    } else if let cinemaGroupCell = cell as? CinemaGroupCell {
      cinemaGroupCell.addSeparator(color: movieDetailsViewModel.separatorColor.cgColor, thickness: 1, leftInset: 0, rightInset: 0)
      
      let group = cinemaGroup[(indexPath.row - 4)/2]
      if let value = movieDetailsViewModel.movieDetails?.pCinemaList[group] {
        cinemaGroupCell.cinemaNameLabel.text = "\(group) (\(value))"
      }
      
    } else if let scheduleCell = cell as? ScheduleCell {
      scheduleCell.tableView.register(UINib(nibName: "CinemaScheduleCell", bundle: nil), forCellReuseIdentifier: "CinemaScheduleCell")
      scheduleCell.tableView.dataSource = scheduleCell
      scheduleCell.tableView.reloadData()
    }
    
    return cell
  }
}

extension MovieDetailsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if let cell = tableView.cellForRow(at: indexPath) as? ScheduleCell {
  
      return cell.height
      
    } else {
      return UITableViewAutomaticDimension
    }
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    if ((tableView.cellForRow(at: indexPath) as? CinemaGroupCell) != nil) {
      if let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: indexPath.section)) as? ScheduleCell {
        tableView.beginUpdates()
        cell.toggle()
        tableView.endUpdates()
      }
    }
  }
}

// MARK: ThumbnailCellDelegate
extension MovieDetailsViewController: ThumbnailCellDelegate {
  func playVideo() {
    movieDetailsViewModel.fetchMovieTrailer(id: movieID) {
      (trailers) in
      guard let trailers = trailers else { return }
      
      var trailerURL = ""
      
      if let url = trailers["v720p"] {
        trailerURL = url
      } else if let url = trailers["v480p"] {
        trailerURL = url
      } else if let url = trailers["v360p"] {
        trailerURL = url
      } else {
        return
      }
      
      guard let url = URL(string: trailerURL) else { return }
      
      let player = AVPlayer(url: url)
      let playerViewController = AVPlayerViewController()
      
      playerViewController.player = player
      self.present(playerViewController, animated: true, completion: {
        playerViewController.player?.play()
      })
      
    }
  }
}

// MARK: MovieSummaryCellDelegate
extension MovieDetailsViewController: MovieSummaryCellDelegate {
  func didClickMoreButton() {
    tableview.beginUpdates()
    tableview.endUpdates()
  }
}

// MARK: UICollectionViewDataSource
extension MovieDetailsViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
    
    let timeInterval = Double(86400 * indexPath.row)
    cell.date = Date(timeInterval: timeInterval, since: self.today!)
    cell.updateDate()
    if indexPath.row == 0 {
      cell.DayOfWeekLabel.text = "Today"
    }
    
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension MovieDetailsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    guard let selectedCell = collectionView.cellForItem(at: indexPath) as? DayCell else { return }
    
    movieDetailsViewModel.fetchScheduleByMovie(id: self.movieID, date: selectedCell.getShortDate(), completionHandler: {
      
      self.tableview.reloadData()

    })
    
    
  }
}




