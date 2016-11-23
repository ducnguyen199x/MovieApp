//
//  VideoView.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/23/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit


protocol VideoControlViewDelegate {
  func playVideo()
  func pauseVideo()
}

class VideoControlView: UIView {
  
  @IBOutlet var playButton: UIButton!
  
  var delegate: VideoControlViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tabOnView))
    addGestureRecognizer(gesture)
    playButton.isHidden = true
  }
  
  func tabOnView() {
    playButton.isHidden = !playButton.isHidden
  }
  
  @IBAction func playButtonClicked(_ sender: UIButton) {
    if sender.isSelected {
      delegate?.playVideo()
      playButton.isHidden = true
    } else {
      delegate?.pauseVideo()
    }
    sender.isSelected = !sender.isSelected
  }
}
