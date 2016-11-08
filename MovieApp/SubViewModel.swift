//
//  ShowingViewModel.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/7/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import Gloss
import RxSwift

class ShowingViewModel : MoviesListViewModel {
  init() {
    super.init(type: .NowShowing)
  }
}

class UpcomingViewModel : MoviesListViewModel {
  init() {
    super.init(type: .Upcoming)
  }
}
