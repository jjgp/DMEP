//
//  UIView+Animate.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import UIKit

extension UIView {
    
    func dissolveFromSuperview(duration: TimeInterval) {
        UIView.animate(withDuration: 2.0,
                       animations: {
                        self.alpha = 0
        },
                       completion: { _ in
                        self.removeFromSuperview()
        })
    }
    
}
