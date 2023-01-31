//
//  LiteNet.swift
//  
//
//  Created by Ilyas Shomat on 18.05.2022.
//

import Foundation
import Combine

public final class LiteNet: LiteNetProtocol {
    private let baseProvider: LiteNetBaseProvider<AnyTarget>
    
    private lazy var provider: LiteNetProvider<AnyTarget> = .init(baseProvider)
    private lazy var publisher: LiteNetProviderPublisher<AnyTarget> = .init(baseProvider)
    
    public init(
        _ baseProvider: LiteNetBaseProvider<AnyTarget>,
        constants: LiteNetConstants
    ) {
        self.baseProvider = baseProvider
        
        LiteNetConstants.shared = constants
    }
    
    public func load(
        target: AnyTargetConvertible,
        onComplete: @escaping JsonEmptyCompletion
    ) {
        provider.request(target.any, jsonCompletion: onComplete)
    }
    
    public func load<T: Codable>(
        target: AnyTargetConvertible,
        jsonType: T.Type,
        onComplete: @escaping JsonCompletion<T>
    ) {
        provider.request(target.any, responseJsonType: jsonType, jsonCompletion: onComplete)
    }
    
    public func load<T: Codable, E: Codable>(
        target: AnyTargetConvertible,
        jsonType: T.Type,
        errorType: E.Type,
        onComplete: @escaping JsonCodableErrorCompletion<T, E>
    ) {
        provider.request(
            target.any,
            responseJsonType: jsonType,
            errorJsonType: errorType,
            jsonCompletion: onComplete
        )
    }
    
    public func loadSubject(target: AnyTargetConvertible) -> PassthroughSubject<Codable, ServiceError> {
        publisher.request(target.any)
    }

    public func loadSubject<T: Codable>(target: AnyTargetConvertible, jsonType: T.Type) -> PassthroughSubject<T, ServiceError> {
        publisher.request(target.any, responseJsonType: jsonType)
    }
    
    public func loadSubject<T: Codable, E: Codable>(
        target: AnyTargetConvertible,
        jsonType: T.Type,
        errorJsonType: E.Type
    ) -> PassthroughSubject<T, E> {
        publisher.request(
            target.any,
            responseJsonType: jsonType,
            errorJsonType: errorJsonType
        )
    }
}
