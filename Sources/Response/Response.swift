//
//  Response.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation

public final class Response: CustomDebugStringConvertible, Equatable {
    public let statusCode: Int
    
    public let data: Data
    
    public let request: URLRequest?
    
    public let response: HTTPURLResponse?
    
    public var debugDescription: String {
        "Status Code: \(statusCode), Data Length: \(data.count)"
    }
    
    public init(
        statusCode: Int,
        data: Data,
        request: URLRequest? = nil,
        response: HTTPURLResponse? = nil
    ) {
        self.statusCode = statusCode
        self.data = data
        self.request = request
        self.response = response
    }
    
    public static func == (lhs: Response, rhs: Response) -> Bool {
        lhs.statusCode == rhs.statusCode &&
        lhs.data == rhs.data &&
        lhs.response == rhs.response
    }
}
