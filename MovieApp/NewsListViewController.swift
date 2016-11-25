//
//  NewsListViewController.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/8/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  
  let newsListViewModel = NewsListViewModel()
  let disposeBag = DisposeBag()
  var refreshControl: UIRefreshControl?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Observe data and update UI
    newsListViewModel.newsListObservable.asObservable().subscribe(onNext: {
      (newsList) in
      
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
    
    newsListViewModel.fetchNews(completionHandler: nil)
  }
  
  // only load data when view is shown
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
    
  }
  
  // Prepare data for segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showNewsDetails" {
      guard let destinationController = segue.destination as? NewsDetailsViewController,
      let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else { return }
      
      destinationController.newsID = newsListViewModel.newsList[selectedIndexPath.row].id
    }
  }
  
  // Refresh data
  func refreshData() {
    newsListViewModel.fetchNews() {
      self.collectionView.reloadData()
      self.refreshControl?.endRefreshing()
    }
  }
  
}

// MARK: UICollectionViewDataSource
extension NewsListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("check-\(newsListViewModel.newsList.count)")
    return newsListViewModel.newsList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
      
    cell.loadImageView(withUrl: newsListViewModel.getNews(atIndex: indexPath.row).image_url)
    cell.loadTitle(title: newsListViewModel.getNews(atIndex: indexPath.row).title)
    cell.loadPublishTime(publishTime: newsListViewModel.getNews(atIndex: indexPath.row).dateUpdate)
    
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension NewsListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
  }
}
