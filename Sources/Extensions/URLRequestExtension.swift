//
//  URLRequestExtension.swift
//
//  Created by Ilyas Shomat on 24.03.2022.
//

import Foundation
import Alamofire

internal extension URLRequest {
    func encoded(parameters: [String: Any], parameterEncoding: ParameterEncoding) -> URLRequest? {
        do {
            return try parameterEncoding.encode(self, with: parameters)
        }
        catch(let error) {
            servicePrint("Error:", error.localizedDescription)
        }
        
        return nil
    }
}
