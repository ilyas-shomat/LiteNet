//
//  File.swift
//  
//
//  Created by Ilyas Shomat on 18.05.2022.
//

import Foundation

public typealias JsonCodableErrorCompletion<C: Codable, E: Codable> = (_ result: DecodedResponse<C, E>) -> Void
public typealias JsonCompletion<C: Codable> = JsonCodableErrorCompletion<C, Empty>
public typealias JsonEmptyCompletion = JsonCompletion<Empty>
