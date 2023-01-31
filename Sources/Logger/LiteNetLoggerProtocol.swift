//
//  LiteNetLogger.swift
//
//  Created by Ilyas Shomat on 24.03.2022.
//

import Foundation

public protocol LiteNetLoggerProtocol {
    func log(data: Any?, error: Error?)
}

public enum LoggerOption {
    case fullLogs
    case errors
    case empty
}

public class LiteNetLogger: LiteNetLoggerProtocol {
    private let option: LoggerOption
    
    public init(option: LoggerOption) {
        self.option = option
    }
    
    public func log(data: Any?, error: Error? = nil) {
        switch option {
        case .fullLogs:
            logFullOptions(data: data, error: error)
        case .errors:
            logErrors(error: error)
        case .empty:
            logEmpty()
        }
    }
    
    private func logFullOptions(data: Any? = nil, error: Error? = nil) {
        if let data = data {
            servicePrint(data)
        }
        if let error = error {
            servicePrint("Error:", error)
        }
    }
    
    private func logErrors(error: Error? = nil) {
        if let error = error {
            servicePrint("Error:", error)
        }
    }
    
    private func logEmpty() {}
}

