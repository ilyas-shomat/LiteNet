//
//  RequestTarget.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation
import Alamofire

public protocol RequestTargetProtocol {
    var baseUrl: String { get }
    
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
        
    var task: RequestTask { get }
}

extension RequestTargetProtocol {
    var fullUrl: URL {
        let fullPath = baseUrl + path
        return URL(string: fullPath)!
    }
    
    var endpoint: Endpoint {
        return .init(
            url: self.fullUrl,
            method: self.method,
            task: self.task,
            headers: self.headers
        )
    }
}
