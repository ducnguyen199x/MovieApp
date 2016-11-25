//
//  ShowingViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/7/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MoviesListViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var viewModel: MoviesListViewModel!
  
  var refreshControl: UIRefreshControl?
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Observe movieList array
    viewModel?.moviesListObservable.asObservable().subscribe(onNext: {
      (moviesList) in
      
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
      
    }, onError: nil, onCompleted: nil, onDisposed: nil)
      .addDisposableTo(disposeBag)
    
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
 
    if #available(iOS 10.0, *) {
      collectionView.refreshControl = refreshControl
    } else {
      // Fallback on earlier versions
    }
    
    viewModel.fetchMovies(completionHandler: nil)
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetailsView" {
      
      guard let destinationViewController = segue.destination as? MovieDetailsViewController, let selectedIndex = collectionView.indexPathsForSelectedItems?.first?.row else { return }
      
      destinationViewController.movieID = viewModel.getMovie(atIndex: selectedIndex).id
      
    }
  }
  
  func refreshData() {
    viewModel.fetchMovies(completionHandler: {
      self.refreshControl?.endRefreshing()
    })
  }
}

// MARK: UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.moviesList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showingCell", for: indexPath) as! MovieCell
    
    cell.loadIMDBPoint(imdb: viewModel.getMovie(atIndex: indexPath.row).imdb)
    cell.loadImage(url: viewModel.getMovie(atIndex: indexPath.row).posterURL)
    cell.movieType = viewModel.getMovie(atIndex: indexPath.row).status
    cell.loadCalendar(date: viewModel.getMovie(atIndex: indexPath.row).publishDate)
    
    return cell
  }
  
}

// MARK: UICollectionViewDelegate
extension MoviesListViewController: UICollectionViewDelegate {
  
}
