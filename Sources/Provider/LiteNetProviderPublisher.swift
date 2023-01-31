//
//  LiteNetProviderPublisher.swift
//  
//
//  Created by Ilyas Shomat on 08.07.2022.
//

import Foundation
import Alamofire
import Combine

public final class LiteNetProviderPublisher<Target: RequestTargetProtocol> {
    let baseProvider: LiteNetBaseProvider<Target>
    
    init(_ baseProvider: LiteNetBaseProvider<Target>) {
        self.baseProvider = baseProvider
    }
    
//    MARK: - Plain Request
    public func request<T: Codable> (
        _ target: RequestTargetProtocol,
        responseJsonType: T.Type
    ) -> PassthroughSubject<T, ServiceError> {
        let subject = PassthroughSubject<T, ServiceError>()
        
        let internalRequest: InternalRequest = .init(
            session: baseProvider.session,
            endpoint: target.endpoint,
            logger: baseProvider.logger
        )
                
        internalRequest.process(
            responseJsonType: responseJsonType,
            errorJsonType: Empty.self,
            jsonCompletion: { result in
                                
                switch result {
                case .success(let decodedJson):
                    if let decodedJson = decodedJson {
                        subject.send(decodedJson)
                    }
                case .failure(let error):
                    if let error = error {
                        subject.send(completion: .failure(error))
                    }
                case .associatedFailure: ()
                }
            }
        )
        
        return subject
    }
    
    
    public func request<T: Codable, E: Codable> (
        _ target: RequestTargetProtocol,
        responseJsonType: T.Type,
        errorJsonType: E.Type
    ) -> PassthroughSubject<T, E> {
        let subject = PassthroughSubject<T, E>()
        
        let internalRequest: InternalRequest = .init(
            session: baseProvider.session,
            endpoint: target.endpoint,
            logger: baseProvider.logger
        )
                
        internalRequest.process(
            responseJsonType: responseJsonType,
            errorJsonType: errorJsonType,
            jsonCompletion: { result in
                                
                switch result {
                case .success(let decodedJson):
                    if let decodedJson = decodedJson {
                        subject.send(decodedJson)
                    }
                case .failure: ()
                case .associatedFailure(let error):
                    if let error = error {
                        subject.send(completion: .failure(error))
                    }
                }
            }
        )
        
        return subject
    }
    
    //    MARK: - Plain request with empty response Json
    public func request (
        _ target: RequestTargetProtocol
    ) -> PassthroughSubject<Codable, ServiceError> {
        let subject = PassthroughSubject<Codable, ServiceError>()
        
        let internalRequest: InternalRequest = .init(
            session: baseProvider.session,
            endpoint: target.endpoint,
            logger: baseProvider.logger
        )
                
        internalRequest.process(
            responseJsonType: Empty.self,
            errorJsonType: Empty.self,
            jsonCompletion: { result in
                                
                switch result {
                case .success(let decodedJson):
                    if let decodedJson = decodedJson {
                        subject.send(decodedJson)
                    }
                case .failure(let error):
                    if let error = error {
                        subject.send(completion: .failure(error))
                    }
                case .associatedFailure: ()
                }
            }
        )
        
        return subject
    }
}
