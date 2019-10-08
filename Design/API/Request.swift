//
//  Request.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

struct Request {
    enum Method: String {
        case get = "GET"
    }
    
    let method: String
    let headers: [String: String]
    let parameters: [Parameter]
    let path: String
    
    init(method: Method = .get,
         headers: [String: String] = [:],
         parameters: [Parameter] = [],
         path: String) {
        self.method = method.rawValue
        self.headers = headers
        self.parameters = parameters
        self.path = path
    }
}
