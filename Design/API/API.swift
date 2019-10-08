//
//  API.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

class API {
    let host: String
    let session: URLSession
    
    init(host: String = "http://localhost:8081", session: URLSession = .shared) {
        self.host = host
        self.session = session
    }
}

fileprivate extension API {
    func URLRequest(from request: Request) -> URLRequest {
        var components = URLComponents(string: "\(host)\(request.path)")!
        components.queryItems = request.parameters.map { URLQueryItem(name: $0.name, value: $0.value) }
        var URLRequest = Foundation.URLRequest(url: components.url!)
        URLRequest.httpMethod = request.method
        return URLRequest
    }
}

extension API {
    @discardableResult
    func fetch(_ request: Request, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: URLRequest(from: request), completionHandler: completion)
        task.resume()
        return task
    }
    
    @discardableResult
    func fetch<D: Decodable>(_ request: Request, completion: @escaping (D?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return fetch(request) { data, response, error in
            let response = response as? HTTPURLResponse
            var decodable: D?
            var completionError = error

            if let code = response?.statusCode,
                200..<400 ~= code,
                let data = data {
                do {
                    decodable = try JSONDecoder().decode(D.self, from: data)
                } catch {
                    decodable = nil
                    completionError = error
                }
            }

            completion(decodable, response, completionError)
        }
    }
}
