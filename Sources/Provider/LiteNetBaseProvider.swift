//
//  LiteNetBaseProvider.swift
//  
//
//  Created by Ilyas Shomat on 08.07.2022.
//

import Foundation
import Alamofire

public class LiteNetBaseProvider<Target: RequestTargetProtocol> {
    let session: Alamofire.Session
    let logger: LiteNetLoggerProtocol
    
    public init(
        session: Alamofire.Session = .default,
        logger: LiteNetLoggerProtocol = LiteNetLogger(option: .fullLogs)
    ) {
        self.session = session
        self.logger = logger
    }
}
