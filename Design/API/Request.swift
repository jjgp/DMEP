//
//  Request.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

enum Method: String {
    case get = "GET"
}

typealias Headers = [String: String]
typealias Parameter = (String, String)
typealias Parameters = [Parameter]

enum RequestError: Error {
    case urlInvalid
}

struct Request<M: Modelable>: Fetchable {
    typealias Model = M
    
    let method: Method
    let headers: Headers
    let parameters: Parameters
    let URLPath: String
    
    init(method: Method = .get,
         headers: Headers = [:],
         parameters: Parameters = [],
         URLPath: String) {
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.URLPath = URLPath
    }
}

extension Request {
    func URLRequest(from host: String) throws -> URLRequest {
        var components = URLComponents(string: "\(host)\(URLPath)")
        components?.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        guard let url = components?.url else {
            throw RequestError.urlInvalid
        }
        
        var request = Foundation.URLRequest(url: url)
        headers.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        request.httpMethod = method.rawValue
        return request
    }
}
