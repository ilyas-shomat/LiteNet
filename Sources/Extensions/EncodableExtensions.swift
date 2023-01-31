//
//  EncodableExtensions.swift
//
//  Created by Ilyas Shomat on 16.03.2022.
//

import Foundation

extension Encodable {
    public var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            servicePrint("ENCODING ERROR: \(error)")
        }
        
        return nil
    }
}
