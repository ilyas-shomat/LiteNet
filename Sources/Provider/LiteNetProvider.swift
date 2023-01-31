//
//  LiteNetProvider.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation
import Alamofire
import Combine
 
public final class LiteNetProvider<Target: RequestTargetProtocol> {
    let baseProvider: LiteNetBaseProvider<Target>
    
    init(_ baseProvider: LiteNetBaseProvider<Target>) {
        self.baseProvider = baseProvider
    }
    
//    MARK: - Plain request
    public func request<T: Codable>(
        _ target: RequestTargetProtocol,
        responseJsonType: T.Type,
        jsonCompletion: @escaping JsonCompletion<T>
    ) {
        let internalRequest: InternalRequest = .init(
            session: baseProvider.session,
            endpoint: target.endpoint,
            logger: baseProvider.logger
        )
        
        internalRequest.process(
            responseJsonType: responseJsonType,
            errorJsonType: Empty.self,
            jsonCompletion: jsonCompletion
        ) 
    }
    
//    MARK: - Plain request with Codable error type
    public func request<T: Codable, E: Codable>(
        _ target: RequestTargetProtocol,
        responseJsonType: T.Type,
        errorJsonType: E.Type,
        jsonCompletion: @escaping JsonCodableErrorCompletion<T, E>
    ) {
        let internalRequest: InternalRequest = .init(
            session: baseProvider.session,
            endpoint: target.endpoint,
            logger: baseProvider.logger
        )
        
        internalRequest.process(
            responseJsonType: responseJsonType,
            errorJsonType: errorJsonType,
            jsonCompletion: jsonCompletion
        )
    }
    
//    MARK: - Plain request with empty response Json
    public func request(
        _ target: RequestTargetProtocol,
        jsonCompletion: @escaping JsonEmptyCompletion
    ) {
        let internalRequest: InternalRequest = .init(
            session: baseProvider.session,
            endpoint: target.endpoint,
            logger: baseProvider.logger
        )
        
        internalRequest.process(
            responseJsonType: Empty.self,
            errorJsonType: Empty.self,
            jsonCompletion: jsonCompletion
        )
    }
}
