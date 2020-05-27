//
//  UIVideoView.swift
//  Spacing
//
//  Created by rvsm on 11/05/20.
//  Copyright © 2020 rvsm. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

/*
 Usage
 self.videoView.load(url: "https://www.youtube.com/embed/afHfMMC-MJE?rel=0")
 self.videoView.loopMode = true
 self.videoView.play()
 */

class VideoView: UIView {
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var loopMode:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func load(url: String) {
        if let videoURL = URL(string: url) {
            print("tem url")
            player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            
            playerLayer?.frame = bounds
            playerLayer?.videoGravity = AVLayerVideoGravity.resize
            
            if let playerLayer = self.playerLayer {
                layer.addSublayer(playerLayer)
            }
            NotificationCenter.default.addObserver(self, selector: #selector(reachEndVideo(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
        }
    }
    
    func play() {
        print("playing")
        if player?.timeControlStatus != AVPlayer.TimeControlStatus.playing {
            player?.play()
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.pause()
        player?.seek(to: CMTime.zero)
    }
    
   @objc func reachEndVideo(_ notification: Notification) {
        if loopMode {
            stop()
            player?.play()
        }
    }
}
