//
//  ServerURLManager.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 29/06/2022.
//

import UIKit

class ServerURLManager: NSObject {
    enum ServerType {
        case stg
        case production
    }
    
    static let serverType: ServerType = .production
    
    static var baseUrl: String {
        switch serverType {
        case .stg:
            return ""
        case .production:
            return ""
        }
    }
}
