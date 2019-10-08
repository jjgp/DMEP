//
//  API.swift
//  Design
//
//  Created by Jason Prasad on 10/3/19.
//  Copyright © 2019 Design. All rights reserved.
//

import Foundation

typealias Headers = [String: String]

struct Parameter {
    let name: String
    let value: String
}

class API {
    struct Configuration {
        let headers: Headers?
        let parameters: [Parameter]?
        
        init(headers: Headers? = nil, parameters: [Parameter]? = nil) {
            self.headers = headers
            self.parameters = parameters
        }
    }
    let configuration: Configuration?
    let host: String
    let session: URLSession
    
    init(host: String = "http://localhost:8081",
         session: URLSession = .shared,
         configuration: Configuration? = nil) {
        self.configuration = configuration
        self.host = host
        self.session = session
    }
}

fileprivate extension API {
    func URLRequest(from request: Request) -> URLRequest {
        var components = URLComponents(string: "\(host)\(request.path)")!
        var queryItems: [URLQueryItem] = []
        let mapParameters = { (parameter: Parameter) in
            queryItems.append(URLQueryItem(name: parameter.name, value: parameter.value))
        }
        request.parameters.forEach(mapParameters)
        configuration?.parameters?.forEach(mapParameters)
        components.queryItems = queryItems
        
        var URLRequest = Foundation.URLRequest(url: components.url!)
        URLRequest.httpMethod = request.method
        configuration?.headers?.forEach() {
            URLRequest.setValue($1, forHTTPHeaderField: $0)
        }
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
