//
//  NetworkError.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation

public enum ServiceError: Error {
    case unknown
    case decoding(message: String)
    case serverError(message: String, statusCode: Int?)
}
