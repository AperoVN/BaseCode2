//
//  ErrorProcessor.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 29/06/2022.
//

import UIKit
import Alamofire

class ErrorProcessor: NSObject {
    static func handleResult<T:Decodable>(_ result: Result<ApiModel<T>, Error>) -> Bool {
        Log("------------Api response: \(result)")
        switch result {
        case .success(let model):
            switch model.code {
            case ErrorCode.success:
                return true
            default:
                return false
            }
        case .failure(_):
            return false
        }
    }
    
    static func handleErr(_ strJson: String) {
        let data = strJson.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String: Any] {
                let code = jsonArray["code"] as? Int
                switch code {
                case ErrorCode.forceUpdate: break
                    
                default:
                    break
                }
            }
        } catch let error as NSError {
            print(error)
        }
    }
}
