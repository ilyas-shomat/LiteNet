//
//  FormData.swift
//  
//
//  Created by Ilyas Shomat on 28.03.2022.
//

import Foundation


public struct FormData {
    public var name: String
    
    public var data: Data
    
    public var mime: MimeType
    
    public init(
        name: String,
        data: Data,
        mime: MimeType
    ) {
        self.name = name
        self.data = data
        self.mime = mime
    }
}


public enum MimeType {
    case plainText
    case pngImage
    case jpegImage
    
    var value: String {
        switch self {
        case .plainText:
            return "text/plain"
        case .pngImage:
            return "image/png"
        case .jpegImage:
            return "image/jpeg"
        }
    }
}
