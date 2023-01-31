//
//  Networkable.swift
//  
//
//  Created by Ilyas Shomat on 11.07.2022.
//

import Foundation
import Combine

public protocol LiteNetProtocol {
    func load(
        target: AnyTargetConvertible,
        onComplete: @escaping JsonEmptyCompletion
    )
    
    func load<T>(
        target: AnyTargetConvertible,
        jsonType: T.Type,
        onComplete: @escaping JsonCompletion<T>
    ) where T : Decodable, T : Encodable
    
    func load<T: Codable, E: Codable>(
        target: AnyTargetConvertible,
        jsonType: T.Type,
        errorType: E.Type,
        onComplete: @escaping JsonCodableErrorCompletion<T, E>
    )
    
    func loadSubject(
        target: AnyTargetConvertible
    ) -> PassthroughSubject<Codable, ServiceError>

    func loadSubject<T>(
        target: AnyTargetConvertible,
        jsonType: T.Type
    ) -> PassthroughSubject<T, ServiceError> where T : Decodable, T : Encodable
    
    func loadSubject<T: Codable, E: Codable>(
        target: AnyTargetConvertible,
        jsonType: T.Type,
        errorJsonType: E.Type
    ) -> PassthroughSubject<T, E>
}
