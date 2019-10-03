//
//  RequestCreators.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

extension Array: Modelable, JSONModelable where Element: Decodable {}

func inspirationRequest(count: Int, authorization: String) -> Request<[Inspiration]> {
    return Request<[Inspiration]>(headers: ["Authorization": authorization],
                                  parameters: [Parameter("count", String(count))],
                                  URLPath: "/inspiration")
}

extension Data: Modelable {
    static func from(data: Data) throws -> Data {
        return data
    }
}

func imageRequest(inspiration: Inspiration, authorization: String) -> Request<Data> {
    let parameters = [
        Parameter("letter", String(inspiration.letter)),
        Parameter("background", inspiration.background),
        Parameter("stroke", String(inspiration.stroke)),
        Parameter("strokeFill", inspiration.strokeFill),
        Parameter("fillOne", inspiration.fillOne),
        Parameter("fillTwo", inspiration.fillTwo),
        Parameter("fillThree", inspiration.fillThree),
        
    ]
    return Request<Data>(headers: ["Authorization": authorization],
                         parameters: parameters,
                         URLPath: "/inspiration/image")
}
