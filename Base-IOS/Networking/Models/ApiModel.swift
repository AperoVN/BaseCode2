//
//  ApiModel.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 29/06/2022.
//

import UIKit

class ApiModel<T: Codable>: NSObject, Codable {
    var code: Int?
    var message: String?
    var data: T?
    var status: Bool?
}

class BaseModel: NSObject, Codable {
    var code: Int?
    var message: String?
    var status: Bool?
}
