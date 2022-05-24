//
//  NetworkService.swift
//  SocketSwift
//
//  Created by regan on 2022/5/18.
//

import Foundation
import AlamofireDomain
import SVProgressHUD

class NetworkService: NetworkProtocol {
    public static let Success:Int = 200
    
    func post(_ dataModel: RequestDataModel, completionHandler: @escaping CompletionHandler, responseErrorHandler: @escaping ResponseErrorHandler) {
        let url:URLConvertible = dataModel.url!
        AlamofireDomain.request(url, method: .post, parameters: dataModel.parameters, encoding: JSONEncoding.default, headers: dataModel.headers)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                let error = response.result.error
                if (error != nil) && response.response?.statusCode != 200 {
                    print("response error \(String(describing: error))")
                    responseErrorHandler(response)
                }
                else{
                    completionHandler(response)
                }
        }
    }
    
    func get(_ dataModel: RequestDataModel, completionHandler: @escaping CompletionHandler,responseErrorHandler:@escaping ResponseErrorHandler ) {
        
        let url:URLConvertible = dataModel.url!
        AlamofireDomain.request(url, method: .get, parameters:dataModel.parameters, encoding: URLEncoding.default, headers: dataModel.headers)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) in
                let error = response.result.error
                if error != nil && response.response?.statusCode != 200 {
                    responseErrorHandler(response)
                }
                else{
                    completionHandler(response)
                }
        }
    }
    
    private func showErrorToast(){
        
        //錯誤處理
        SVProgressHUD.dismiss()
        SVProgressHUD.showInfo(withStatus: "網路錯誤，請檢查網路環境")
        SVProgressHUD.dismiss(withDelay: 2)
    }
}
