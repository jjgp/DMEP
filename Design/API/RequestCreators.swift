//
//  RequestCreators.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

extension Array: Modelable where Element: Decodable {}

func inspirationRequest(count: Int, authorization: String? = nil) -> Request<[Inspiration]> {
    return Request<[Inspiration]>(
        headers: authorization == nil ? [:] : ["Authorization": authorization!],
        parameters: [Parameter("count", "\(count)")],
        URLPath: "/inspiration")
}
