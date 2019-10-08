//
//  RequestCreators.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

extension Request {
    static func inspiration(count: Int) -> Request {
        return Request(parameters: [.init(name: "count", value: String(count))],
                       path: "/inspiration")
    }
    
    static func image(inspiration: Inspiration) -> Request {
        let parameters: [Parameter] = [
            .init(name: "letter", value: String(inspiration.letter)),
            .init(name: "background", value: inspiration.background),
            .init(name: "stroke", value: String(inspiration.stroke)),
            .init(name: "strokeFill", value: inspiration.strokeFill),
            .init(name: "fillOne", value: inspiration.fillOne),
            .init(name: "fillTwo", value: inspiration.fillTwo),
            .init(name: "fillThree", value: inspiration.fillThree),
            
        ]
        return Request(parameters: parameters,
                       path: "/inspiration/image")
    }
}
