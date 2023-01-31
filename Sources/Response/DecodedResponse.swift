//
//  DecodedResponse.swift
//
//  Created by Ilyas Shomat on 16.03.2022.
//

import Foundation

public enum DecodedResponse<Value, AssociatedError: Codable> {
    case success(Value?)
    case failure(ServiceError?)
    case associatedFailure(AssociatedError?)
}
