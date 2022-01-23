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
    
    private var model: [String] = ["https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8", "https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8","https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8","https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8","https://multiplatform-f.akamaihd.net/i/multi/april11/sintel/sintel-hd_,512x288_450_b,640x360_700_b,768x432_1000_b,1024x576_1400_m,.mp4.csmil/master.m3u8"]
    
    private var assetPlayer: AssetPlayer!
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlayer()
        setPlayerView()
        setPlayListTableView()
        
        assetPlayer.play()
    }
    
    func setPlayer() {
        self.assetPlayer = AssetPlayer.shared
        assetPlayer.initPlayer(url: URL(string: model.first!)!, nowPlayableBehavior: self)
    }
    
    func setPlayerView() {
        self.playerView.player = self.assetPlayer.player
        self.view.addSubview(playerView)
    }
    
    func setPlayListTableView() {
        playListTableView.dataSource = self
        playListTableView.delegate = self
        playListTableView.register(PlayListTableViewCell.self, forCellReuseIdentifier: "PlayListTableViewCell")
        playListTableView.register(MediaInfoViewCell.self, forCellReuseIdentifier: "MediaInfoViewCell")
        playListTableView.tableFooterView = UIView()
        playListTableView.backgroundColor = .clear
        playListTableView.rowHeight = UITableView.automaticDimension
        playListTableView.estimatedRowHeight = 200
        playListTableView.contentInsetAdjustmentBehavior = .never
        
        if #available(iOS 15.0, *) {
            playListTableView.sectionHeaderTopPadding = 0
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

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return model.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "MediaInfoViewCell", for: indexPath) as? MediaInfoViewCell ?? UITableViewCell()
            
            cell.backgroundColor = .yellow
            cell.textLabel?.text = "현재 재생되는 미디어 정보"
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "PlayListTableViewCell", for: indexPath) as? PlayListTableViewCell  ?? UITableViewCell()
            cell.textLabel?.text = model[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .darkGray
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView(frame: .zero)
        } else {
            let headerView = UIView()
            headerView.backgroundColor = .red
            headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50)
            
            let titleLabel = UILabel()
            titleLabel.textColor = .green
            titleLabel.text = "Section\(section) 헤더 뷰"
            titleLabel.frame = CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
            headerView.addSubview(titleLabel)
            
            return headerView
        }
    }
}
