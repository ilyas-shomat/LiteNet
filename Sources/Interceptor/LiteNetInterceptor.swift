//
//  LiteNetInterceptor.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation
import Alamofire

final class LiteNetInterceptor: RequestInterceptor {
    public typealias AdaptHandler = (Result<URLRequest, Error>) -> ()
    public typealias RetryHandler = (RetryResult) -> ()
    
    private let endpoint: Endpoint
    
    private var headers: HTTPHeaders {
        var headers: HTTPHeaders = .init()
        
        switch endpoint.task {
        case .uploadFormData:
            headers["Content-Type"] = "multipart/form-data"
        default:
            headers["Content-Type"] = "application/json"
        }
        
        _ = endpoint.headers?.map { (key, value) in
            headers.add(HTTPHeader(name: key, value: value))
        }
        
        return headers
    }
    
    private var bodyParameters: Data? {
        switch endpoint.task {
        case .requestEmpty, .requestQuery, .uploadFormData:
            return nil
        case .requestEncodableBody(let encodable):
            guard let data = encodable.data else {
                return Data()
            }
            return data
        }
    }
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping AdaptHandler) {
        var request = urlRequest
        
        request.method = endpoint.method
        request.headers = headers
        request.httpBody = bodyParameters
                
        completion(.success(request))
    }
}
