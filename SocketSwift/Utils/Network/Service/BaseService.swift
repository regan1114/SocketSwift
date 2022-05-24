//
//  BaseService.swift
//  SocketSwift
//
//  Created by regan on 2022/5/18.
//

import Foundation

class BaseService: NSObject {

    static func post(_ dataModel:RequestDataModel , completionHandler : @escaping CompletionHandler,responseErrorHandler:@escaping ResponseErrorHandler ) {
        NetworkService().post(dataModel, completionHandler: completionHandler, responseErrorHandler: responseErrorHandler)
    }
    
    static func get(_ dataModel: RequestDataModel , completionHandler: @escaping CompletionHandler,responseErrorHandler:@escaping ResponseErrorHandler ) {
        NetworkService().get(dataModel, completionHandler: completionHandler, responseErrorHandler: responseErrorHandler)
    }
}
