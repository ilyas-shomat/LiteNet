//
//  AnyTarget.swift
//  
//
//  Created by Ilyas Shomat on 18.05.2022.
//

import Foundation
import Alamofire

public final class AnyTarget: BaseApiTarget {
    let target: RequestTargetProtocol
    
    public var baseUrl: String {
        return target.baseUrl
    }
    
    public var path: String {
        return target.path
    }
    
    public var method: HTTPMethod {
        return target.method
    }
    
    public var headers: [String : String]? {
        return target.headers
    }
    
    public var task: RequestTask {
        return target.task
    }
    
    init(_ target: RequestTargetProtocol) {
        self.target = target
    }
}

public protocol AnyTargetConvertible {
    var any: AnyTarget { get }
}

public extension AnyTargetConvertible where Self: RequestTargetProtocol {
    var any: AnyTarget {
        return AnyTarget(self)
    }
}
