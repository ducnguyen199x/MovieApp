//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher
import FLEX

class MovieDetailsViewController: UIViewController {
  
  @IBOutlet var thumbnail: UIImageView!
  @IBOutlet var movieNameLabel: UILabel!
  @IBOutlet var imdbStarImage: UIImageView!
  @IBOutlet var imdbPointLabel: UILabel!
  @IBOutlet var durationLabel: UILabel!
  @IBOutlet var publishDateLabel: UILabel!
  @IBOutlet var movieTypeLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  @IBOutlet var directorLabel: UILabel!
  @IBOutlet var writerLabel: UILabel!
  @IBOutlet var starLabel: UILabel!
  @IBOutlet var pgRatingLabel: UILabel!
  
  let movieDetailsViewModel = MovieDetailsViewModel()
  var movieID: String?
  
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
    
    loadData()
    
//    #if DEBUG
//      FLEXManager.shared().showExplorer()
//    #endif
  }
  
  override func viewDidAppear(_ animated: Bool) {

    navigationController?.navigationBar.isHidden = false

  }
  
  func back() {
    _ = navigationController?.popViewController(animated: true)
  }
  
  func loadData() {
    movieDetailsViewModel.fetchMovieDetails(id: movieID) {
      (movieDetails) in
      
      print(movieDetails?.id)
      
      guard let movieDetails = movieDetails else { return }
      
      self.thumbnail.kf.setImage(with: URL(string: movieDetails.posterLandscapeURL!))
      self.pgRatingLabel.text = movieDetails.pgRating
      self.movieNameLabel.text = movieDetails.name!
      self.imdbPointLabel.text = "\(movieDetails.imdb!) IMDB"
      self.durationLabel.text = movieDetails.duration?.minutesToHours()
      self.publishDateLabel.text = movieDetails.getPublishDateString()
      self.descriptionLabel.text = movieDetails.description!
      self.directorLabel.text = movieDetails.getDirector()
      self.starLabel.text = movieDetails.getStars()
      
    }
  }
  
  @IBAction func moreButtonClicked(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    
    UILabel.animate(withDuration: 0.2) {
      if sender.isSelected {
        self.descriptionLabel.numberOfLines = 0
      } else {
        self.descriptionLabel.numberOfLines = 3
      }
      self.descriptionLabel.sizeToFit()
    }
    
  }

  @IBAction func playButtonClicked(_ sender: Any) {
  }
  
}







