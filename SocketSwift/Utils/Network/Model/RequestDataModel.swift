//
//  RequestDataModel.swift
//  SocketSwift
//
//  Created by regan on 2022/5/18.
//
import UIKit
import Alamofire

public enum HTTPParamType {
    case array
    case dictionary
}

public protocol HTTPParameterProtocol {
    func paramType() -> HTTPParamType
}

extension Dictionary: HTTPParameterProtocol {
    public func paramType() -> HTTPParamType {
        return .dictionary
    }
}

extension Array: HTTPParameterProtocol {
    public func paramType() -> HTTPParamType {
        return .array
    }
}

public class RequestDataModel:NSObject {
    var url : URL?
    
    var parameters:Parameters = [:]
    
    var headers:HTTPHeaders? = nil
    
    var data : Data?
    
    var fileURL : URL?
    
    override init() {
        super.init()
    }
}
