//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
  
  @IBOutlet var thumbnail: UIImageView!
  
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
      
      guard let movieDetails = movieDetails else { return }
      
      self.thumbnail.kf.setImage(with: URL(string: movieDetails.posterLandscapeURL!))
      
    }
  }
}







