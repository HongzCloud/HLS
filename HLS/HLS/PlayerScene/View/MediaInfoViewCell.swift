//
//  MediaInfoViewCell.swift
//  HLS
//
//  Created by 오킹 on 2022/01/23.
//

import UIKit

class MediaInfoViewCell: UITableViewCell {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mediaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUIObjects()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUIObjects()
    }
    
    private func setUIObjects() {
        setTitleLabel()
    }
    
    private func setTitleLabel() {
        self.titleLabel.text = "test"
        
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
