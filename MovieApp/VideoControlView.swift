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
  func replayVideo()
  func sliderValueChanged(value: Float)
}

class VideoControlView: UIView {
  
  @IBOutlet var playButton: UIButton!
  @IBOutlet var slider: UISlider!
  @IBOutlet var currentTimeLabel: UILabel!
  @IBOutlet var maxTimeLabel: UILabel!
  
  var delegate: VideoControlViewDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tabOnView))
    addGestureRecognizer(gesture)
    toggleControl()
  }
  
  func tabOnView() {
    toggleControl()
  }
  
  func toggleControl() {
    playButton.isHidden = !playButton.isHidden
    slider.isHidden = !slider.isHidden
    currentTimeLabel.isHidden = !currentTimeLabel.isHidden
    maxTimeLabel.isHidden = !maxTimeLabel.isHidden
    
    if playButton.isHidden {
      backgroundColor = UIColor(white: 0, alpha: 0)
    } else {
      backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
  }
  
  @IBAction func playButtonClicked(_ sender: UIButton) {
    if sender.isSelected {
      if slider.value == 1 {
        delegate?.replayVideo()
      } else {
        delegate?.playVideo()
      }
      toggleControl()
    } else {
      delegate?.pauseVideo()
    }
    sender.isSelected = !sender.isSelected
  }
  
  @IBAction func sliderValueChanged(_ sender: Any) {
    delegate?.sliderValueChanged(value: slider.value)
    
  }
  
}
