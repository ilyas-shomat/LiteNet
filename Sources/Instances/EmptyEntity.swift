//
//  EmptyEntity.swift
//  
//
//  Created by Ilyas Shomat on 30.03.2022.
//

import Foundation

/// Static `Empty` instance used for all `Empty` responses.

public struct Empty: Codable {
    public static let value = Empty()
}
