//
//  DesignTableViewCell.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import UIKit

class DesignTableViewCell: UITableViewCell {
    var designImageView: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        designImageView = UIImageView()
        designImageView.contentMode = .center
        designImageView.image = UIImage(named: "Loading")
        designImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(designImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DesignTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        
        designImageView.image = UIImage(named: "Loading")
    }
}

extension DesignTableViewCell {
    func take(_ inspiration: Inspiration) {
        
    }
}

extension DesignTableViewCell {
    func setupConstraints() {
        contentView.addConstraints([
            .init(item: designImageView!,
                  attribute: .top,
                  relatedBy: .equal,
                  toItem: contentView,
                  attribute: .top,
                  multiplier: 1,
                  constant: 0),
            .init(item: designImageView!,
                  attribute: .trailing,
                  relatedBy: .equal,
                  toItem: contentView,
                  attribute: .trailing,
                  multiplier: 1,
                  constant: 0),
            .init(item: designImageView!,
                  attribute: .bottom,
                  relatedBy: .equal,
                  toItem: contentView,
                  attribute: .bottom,
                  multiplier: 1,
                  constant: 0),
            .init(item: designImageView!,
                  attribute: .leading,
                  relatedBy: .equal,
                  toItem: contentView,
                  attribute: .leading,
                  multiplier: 1,
                  constant: 0),
        ])
    }
}
