//
//  APIRouter.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 29/06/2022.
//

import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptCharset = "Accept-Charset"
}

enum ContentType: String {
    case json = "application/json;charset=utf-8"
}

enum AcceptType: String {
    case json = "application/json"
}

enum AcceptCharset: String {
    case utf8 = "utf-8"
}

struct APIRouter: URLRequestConvertible {
    let path: String
    let httpMethod: HTTPMethod
    let token: String?
    let parameters: Parameters?
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
//        let url = try ServerURLManager.baseUrl.asURL()
        var apiPath = path
        var params = parameters
        if httpMethod == .get {
            apiPath = path.standardUrlPath(withParams: parameters)
            params = nil
        }
        
//        var urlRequest = URLRequest(url: url.appendingPathComponent(apiPath))
        var urlRequest = URLRequest(url: try (ServerURLManager.baseUrl + apiPath).asURL())
        
        // HTTP Method
        urlRequest.httpMethod = httpMethod.rawValue
        
        // Common Headers
        urlRequest.setValue(AcceptType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(AcceptCharset.utf8.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptCharset.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let _ = token {
            urlRequest.setValue(token!, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        
        // Parameters
        if let parameters = params {
            do {
                let json = try JSONSerialization.data(withJSONObject: parameters, options: [])
                urlRequest.httpBody = json
//                Log(String(decoding: json, as: UTF8.self))
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        Log("---------Api Request: \(urlRequest.description)")
        
        return urlRequest
    }
}

