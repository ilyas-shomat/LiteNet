//
//  BaseApiTarget.swift
//  
//
//  Created by Ilyas Shomat on 18.05.2022.
//

import Foundation

public protocol BaseApiTarget: RequestTargetProtocol {}

public extension BaseApiTarget {
    var baseUrl: String {
        return LiteNetConstants.shared.getCurrentBaseUrl()
    }
}
