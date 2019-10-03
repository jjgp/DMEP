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
    
    init(host: String = "http://localhost:8081",
         session: URLSession = .shared) {
        self.host = host
        self.session = session
    }
}

enum ModelableError: Error {
    case fromJSONData(reason: Error)
}

public protocol Modelable: Decodable {
    static func from(json data: Data) throws -> Self
}

extension Modelable {
    public static func from(json data: Data) throws -> Self {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            throw ModelableError.fromJSONData(reason: error)
        }
    }
}

protocol Fetchable {
    associatedtype Model: Modelable
    
    func URLRequest(from host: String) throws -> URLRequest
}

extension API {
    typealias Completion<M: Modelable> = (M?, HTTPURLResponse?, Error?) -> Void
    
    @discardableResult
    func fetch<F: Fetchable>(_ request: F, completion: Completion<F.Model>? = nil) -> URLSessionDataTask {
        let task = session.dataTask(with: try! request.URLRequest(from: host)) { data, response, error in
            guard let completion = completion else {
                return
            }
            
            let response = response as? HTTPURLResponse
            var model: F.Model?
            var completionError = error
            
            if let code = response?.statusCode,
                200..<400 ~= code,
                let data = data {
                do {
                    model = try F.Model.from(json: data)
                } catch {
                    model = nil
                    completionError = error
                }
            }
            
            completion(model, response, completionError)
        }
        task.resume()
        
        return task
    }
    
}
