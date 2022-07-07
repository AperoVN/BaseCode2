//
//  APIClient.swift
//  Base-IOS
//
//  Created by Đinh Văn Trình on 29/06/2022.
//

import Alamofire

class APIClient: NSObject {
    private static func performRequest<T:Decodable>(router: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, AFError>) -> Void) {
        let _ = AF.request(router).responseDecodable(decoder: decoder){ (response: AFDataResponse<T>) in
            if let data = response.data {
                let jsonStr = String(data: data, encoding: String.Encoding.utf8)
                Log("---------Api response \(response.request?.url?.absoluteString ?? ""): \(jsonStr ?? "")")
                ErrorProcessor.handleErr(jsonStr!)
            } else {
                Log("---------Api response \(response.request?.url?.absoluteString ?? ""): data = nil error")
            }
            completion(response.result)
        }
    }
    
    private static func apiRouter(path: String, httpMethod: HTTPMethod, hasToken: Bool = true, parameters: Parameters?) -> APIRouter {
        var token: String? = nil
        if hasToken {
            token = ""
        }
        return APIRouter(path: path, httpMethod: httpMethod, token: token, parameters: parameters)
    }
    
    private static func performUpload<T:Decodable>(data: Data, router: APIRouter,
                                                   decoder: JSONDecoder = JSONDecoder(),
                                                   completion: @escaping (Result<T, AFError>) -> Void) {
        let params = router.parameters
        
        let request = AF.upload(multipartFormData: { (multipartFormData) in
            if let parameters = params {
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            multipartFormData.append(data, withName: "file", fileName: "image.png", mimeType: "image/png")
        }, with: router)
        
        let _ = request.responseDecodable(decoder: decoder){ (response: AFDataResponse<T>) in
            if let data = response.data {
                let jsonStr = String(data: data, encoding: String.Encoding.utf8)
                Log("---------Api response: \(jsonStr ?? "")")
            } else {
                Log("---------Api response: data = nil")
            }
            completion(response.result)
        }
    }
    
}

extension APIClient {
    
    static func logout(completion: @escaping (Result<ApiModel<[BaseModel]>, AFError>) -> Void) {
        let params = Parameters()
        let r = APIRouter(path: APIPath.logout, httpMethod: .post, token: "", parameters: params)
        performRequest(router: r, completion: completion)
    }
}
