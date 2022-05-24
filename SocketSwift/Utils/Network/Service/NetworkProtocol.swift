//
//  NetworkProtocol.swift
//  SocketSwift
//
//  Created by regan on 2022/5/18.
//

import Foundation
import AlamofireDomain

public typealias CompletionHandler = ((DataResponse<Any>) -> Void)

public typealias ResponseErrorHandler = ((DataResponse<Any>) -> Void)

public protocol NetworkProtocol {
    func post(_ dataModel:RequestDataModel,completionHandler:@escaping CompletionHandler,responseErrorHandler:@escaping ResponseErrorHandler)
    
    func get(_ dataModel :RequestDataModel,completionHandler:@escaping CompletionHandler, responseErrorHandler:@escaping ResponseErrorHandler)
}
