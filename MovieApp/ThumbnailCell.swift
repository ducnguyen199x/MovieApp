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
    
    player = AVPlayer(url: url)
    playerLayer = AVPlayerLayer(player: player)
    if let playerLayer = playerLayer {
      playerLayer.frame = thumbnail.frame
      playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
      thumbnail.layer.addSublayer(playerLayer)
    }
    if let videoControlView = videoControlFromNibName("VideoControlView") {
      videoControlView.delegate = self
      thumbnail.addSubview(videoControlView)
    }
    
    player?.play()
    
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
}





