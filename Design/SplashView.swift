//
//  SplashView.swift
//  Design
//
//  Created by Jason Prasad on 9/29/19.
//  Copyright © 2019 Design. All rights reserved.
//

import UIKit

class SplashView: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1, green: 17.0 / 255.0, blue: 126.0 / 255.0, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didMoveToSuperview() {
        superview?.addConstraints([
            .init(item: self,
                  attribute: .top,
                  relatedBy: .equal,
                  toItem: superview,
                  attribute: .top,
                  multiplier: 1,
                  constant: 0),
            .init(item: self,
                  attribute: .trailing,
                  relatedBy: .equal,
                  toItem: superview,
                  attribute: .trailing,
                  multiplier: 1,
                  constant: 0),
            .init(item: self,
                  attribute: .bottom,
                  relatedBy: .equal,
                  toItem: superview,
                  attribute: .bottom,
                  multiplier: 1,
                  constant: 0),
            .init(item: self,
                  attribute: .leading,
                  relatedBy: .equal,
                  toItem: superview,
                  attribute: .leading,
                  multiplier: 1,
                  constant: 0),
        ])
    }
}

extension SplashView {
    func drawD() {
        let center = CGPoint(x: self.center.x + 6.5, y: self.center.y)
        
        func drawCircle(_ radius: CGFloat) {
            let circle = CAShapeLayer()
            circle.path = UIBezierPath(arcCenter: center,
                                       radius: radius,
                                       startAngle: 0,
                                       endAngle: 2 * .pi,
                                       clockwise: true).cgPath
            circle.fillColor = UIColor.clear.cgColor
            circle.lineWidth = 1
            circle.strokeColor = UIColor.white.cgColor
            layer.addSublayer(circle)
        }
        drawCircle(76)
        drawCircle(17)
        
        let rectangle = CAShapeLayer()
        let rectangleRect = CGRect(x: center.x - 88.5, y: center.y - 76, width: 33, height: 152)
        rectangle.path = UIBezierPath(roundedRect: rectangleRect,
                                      cornerRadius: 0).cgPath
        rectangle.fillColor = UIColor.clear.cgColor
        rectangle.lineWidth = 1
        rectangle.strokeColor = UIColor.white.cgColor
        layer.addSublayer(rectangle)
    }
}

extension SplashView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        drawD()
        
        let animations = {
            self.alpha = 0
        }
        let completion: (Bool) -> Void = { _ in
            self.removeFromSuperview()
        }
        UIView.animate(withDuration: 2.0,
                       animations: animations,
                       completion: completion)
    }
}
