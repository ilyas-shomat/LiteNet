//
//  LiteNetConstants.swift
//  
//
//  Created by Ilyas Shomat on 18.05.2022.
//

import Foundation

public struct LiteNetConstants {
    static var shared: LiteNetConstants = .init()
    
    var isDebug: Bool
    
    var debugUrl: String
    
    var releaseUrl: String
    
    public init(
        isDebug: Bool = true,
        debugUrl: String = "",
        releaseUrl: String = ""
    ) {
        self.isDebug = isDebug
        self.debugUrl = debugUrl
        self.releaseUrl = releaseUrl
    }
    
    func getCurrentBaseUrl() -> String {
        if isDebug {
            return debugUrl
        }
        else {
            return releaseUrl
        }
    }
}


