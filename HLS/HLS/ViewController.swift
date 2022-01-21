//
//  ViewController.swift
//  HLS
//
//  Created by 오킹 on 2022/01/20.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    private var playerView: PlayerView!
    private var assetPlayer: AssetPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayer()
        setPlayerView()
        
        assetPlayer.play()
    }

    func setPlayer() {
        self.assetPlayer = AssetPlayer.shared
        assetPlayer.initPlayer(url: URL(string: "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8")!, nowPlayableBehavior: self)
    }
    
    func setPlayerView() {
        self.playerView = PlayerView()
        self.playerView.player = self.assetPlayer.player
        self.view.addSubview(playerView)
        
        self.playerView.frame = .init(x: self.view.frame.maxX-50, y: self.view.frame.midY, width: 10, height: 50)
        var frame = playerView.frame
        frame.origin = CGPoint(x: 0, y: self.view.frame.midY)
        frame.size = CGSize(width: self.view.frame.width, height: 50)
        
        UIView.animate(withDuration: 1.0) {
            self.playerView.frame = frame
        } completion: { bool in
            UIView.animate(withDuration: 1.0) {
                self.playerView.frame.size = CGSize(width: self.view.frame.width+20, height: 100)
            }
        }
    }
}

extension ViewController: NowPlayable {
    var defaultAllowsExternalPlayback: Bool {
        return false
    }
    
    var defaultCommands: [NowPlayableCommand] {
        [.play, .pause]
    }
}
