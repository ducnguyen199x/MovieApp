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
    
  }
}

// MARK: UICollectionViewDataSource
extension NewsListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return newsListViewModel.newsList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
      
    cell.loadImageView(withUrl: newsListViewModel.getNews(atIndex: indexPath.row).image_url)
    
    return cell
  }
}

// MARK: UICollectionViewDelegate
extension NewsListViewController: UICollectionViewDelegate {
  
}
