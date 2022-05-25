//
//  NetworkService.swift
//  SocketSwift
//
//  Created by regan on 2022/5/18.
//

import Foundation
import Alamofire
//import AlamofireDomain

class NetworkService: NetworkProtocol {
    public static let Success:Int = 200
    func post(_ dataModel: RequestDataModel, completionHandler: @escaping CompletionHandler, responseErrorHandler: @escaping ResponseErrorHandler) {
        let url:URLConvertible = dataModel.url!
        Alamofire.request(url, method: .post, parameters: dataModel.parameters, encoding: URLEncoding.default, headers: dataModel.headers)
            .validate(contentType: ["application/json"])
            .response { response in
                let error = response.error
                if (error != nil) &&
                    response.response?.statusCode != NetworkService.Success {
                    responseErrorHandler(response)
                } else {
                    completionHandler(response)
                }
        }
    }
    
    func get(_ dataModel: RequestDataModel, completionHandler: @escaping CompletionHandler, responseErrorHandler: @escaping ResponseErrorHandler) {
        let url:URLConvertible = dataModel.url!
        Alamofire.request(url, method: .get, parameters: dataModel.parameters, encoding: URLEncoding.default, headers: dataModel.headers)
            .validate(contentType: ["application/json"])
            .response { response in
                let error = response.error
                if (error != nil) &&
                    response.response?.statusCode != NetworkService.Success {
                    responseErrorHandler(response)
                } else {
                    completionHandler(response)
                }
        }
    }
}
