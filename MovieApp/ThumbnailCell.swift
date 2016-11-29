//
//  ThumbnailCell.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/16/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher
import AVKit
import AVFoundation
import RxSwift
import RxCocoa

protocol ThumbnailCellDelegate {
  func playVideo()
}

class ThumbnailCell: UITableViewCell {
  
  @IBOutlet var thumbnail: UIImageView!
   
  @IBOutlet var playButton: UIButton!
  var movieTrailers: [String: String]? = nil
  var delegate: ThumbnailCellDelegate? = nil
  var player: AVPlayer?
  var playerLayer: AVPlayerLayer?
  var videoControlView: VideoControlView?
  
  // Play trailer
  @IBAction func playButtonClicked(_ sender: Any) {
    guard let trailers = movieTrailers else { return }
    playButton.isHidden = true
    
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
    
    // set up AVPlayer
    player = AVPlayer(url: url)
    playerLayer = AVPlayerLayer(player: player)
    
    if let playerLayer = playerLayer {
      playerLayer.frame = thumbnail.frame
      playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      thumbnail.layer.addSublayer(playerLayer)
    }
    if let controlView = videoControlFromNibName("VideoControlView") {
      controlView.delegate = self
      thumbnail.addSubview(controlView)
      videoControlView = controlView
    }
    
    player?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, 1) , queue: DispatchQueue.main, using: { (progressTime) in
      
      let seconds = CMTimeGetSeconds(progressTime)
      let secondsString = String(format: "%02d", Int(seconds) % 60)
      let minutesString = String(format: "%02d", Int(seconds) / 60)

      self.videoControlView?.currentTimeLabel.text = "\(minutesString):\(secondsString)"
      
      // move slider thumb
      if let duration = self.player?.currentItem?.duration {
        let durationSeconds = CMTimeGetSeconds(duration)
        
        let value = Float(seconds / durationSeconds)
        self.videoControlView?.slider.value = value
        
        if value == 1 {
          self.videoControlView?.playButton.isSelected = true
        }
      }
      
    })
    
    player?.addObserver(self, forKeyPath: "currentItem.duration", options: .new, context: nil)
    
    player?.play()
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "currentItem.duration" {
      if let duration = player?.currentItem?.duration {
        let totalSeconds = CMTimeGetSeconds(duration)
        
        let secondsString = String(format: "%02d", Int(totalSeconds) % 60)
        let minutesString = String(format: "%02d", Int(totalSeconds) / 60)
        self.videoControlView?.maxTimeLabel.text = "\(minutesString):\(secondsString)"
      }
    
    }
  }
  
  // Load thumbnail
  func loadThumbnail(url: String?) {
    guard let url = url else { return }
    
    thumbnail.kf.setImage(with: URL(string: url))
  }
  
  // load View from nib
  func videoControlFromNibName(_ name: String) -> VideoControlView? {
    let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
    return views?.first as? VideoControlView
  }
  
  func stopVideo() {
    player?.pause()
    playerLayer?.removeFromSuperlayer()
    player = nil
  }
}

//MARK: VideoControlViewDelegate
extension ThumbnailCell: VideoControlViewDelegate {
  func playVideo() {
    player?.play()
  }
  
  func pauseVideo() {
    player?.pause()
  }
  
  func replayVideo() {
    player?.seek(to: kCMTimeZero)
    player?.play()
  }
  
  func sliderValueChanged(value: Float) {
    if let duration = player?.currentItem?.duration {
      let totalSeconds = CMTimeGetSeconds(duration)
      let value = Float64(value) * totalSeconds
      let seekTime = CMTime(value: Int64(value), timescale: 1)

      player?.seek(to: seekTime)
    }
  }
}





