//
//  Endpoint.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation
import Alamofire

class Endpoint {
    let url: URL
    
    let method: Alamofire.HTTPMethod

    let task: RequestTask
    
    let headers: [String: String]?
    
    var urlRequest: URLRequest {
        switch task {
        case .requestEmpty, .requestEncodableBody:
            return .init(url: url)
        case .requestQuery(let parameters):
            guard let urlRequest = setQueryParameters(
                url: url,
                parameters: parameters
            ) else {
                return .init(url: url)
            }
            return urlRequest
        case .uploadFormData(_):
            return .init(url: url)
        }
    }
        
    init(
        url: URL,
        method: Alamofire.HTTPMethod,
        task: RequestTask,
        headers: [String: String]?
    ) {
        self.url = url
        self.method = method
        self.task = task
        self.headers = headers
    }
    
    private func setQueryParameters(url: URL, parameters: [String: Any]) -> URLRequest? {
        let urlRequest = URLRequest(url: url)
        return urlRequest.encoded(
            parameters: parameters,
            parameterEncoding: URLEncoding.queryString
        )
    }
}

