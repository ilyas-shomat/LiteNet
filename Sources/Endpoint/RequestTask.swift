//
//  Task.swift
//
//  Created by Ilyas Shomat on 15.03.2022.
//

import Foundation

public enum RequestTask {
    case requestEmpty
    
    case requestQuery([String: Any])
    
    case requestEncodableBody(Codable)
    
    case uploadFormData([FormData])
}
