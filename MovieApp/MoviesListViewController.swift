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
  
  let disposeBag = DisposeBag()
  @IBOutlet var viewModel: MoviesListViewModel!

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
  }
}

// MARK: UICollectionViewDataSource
extension MoviesListViewController: UICollectionViewDataSource {
  
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
