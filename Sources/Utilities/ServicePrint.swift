//
//  ServicePrint.swift
//
//  Created by Ilyas Shomat on 16.03.2022.
//

import Foundation

internal func servicePrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print("\n LiteNet --------------------------- \n")
    debugPrint(items, separator: separator, terminator: terminator)
    print("------------------------------------------")
    #endif
}

internal func servicePrint(_ item: Any) {
    #if DEBUG
    print("\n LiteNet --------------------------- \n")
    debugPrint(item)
    print("------------------------------------------")
    #endif
}

