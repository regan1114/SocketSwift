//
//  SocketService.swift
//  SocketSwift
//
//  Created by regan on 2022/5/19.
//

import Foundation
import UIKit
import Combine

enum WebSocketStatus {
   case WebSocketStatusDefault //初始狀態，未連接
   case WebSocketStatusConnect //已連接
   case WebSocketStatusDisConnect //斷開連接
}

class SocketService:NSObject {
    
    typealias socketDidReceiveMessageClosure = (_ results:String) -> Void
    var socketDidReceiveMessage:socketDidReceiveMessageClosure?
    var socketStatus:WebSocketStatus = WebSocketStatus.WebSocketStatusDefault
    
    //心跳定時器
    var headerBeatTime:Timer = Timer()
    //沒有網絡的時候檢測定時器
    var networkTestingTimer:Timer = Timer()
    //重連時間
    var reConnectTime:TimeInterval = 0
    //存儲要發送給服務器的數據
    var sendDataArray:NSMutableArray = NSMutableArray()
    //用於判斷是否主動關閉長連接，如果是主動斷開連接，連接失敗的代理中，就不用執行重新連接方法
    var isActiveClose:Bool = false
    
    var isConnect: Bool = false
    
    private let urlSession = URLSession(configuration: .default)
    private var webSocketTask: URLSessionWebSocketTask?
    
    //Use the class constant approach if you are using Swift 1.2 or above and the nested struct approach if you need to support earlier versions.
    //Class constant
    static let shared = SocketService()
    //Nested struct
//    class var shared: SocketService {
//        struct Static {
//            static let instance: SocketService = SocketService()
//        }
//        return Static.instance
//    }
    
    private override init(){
        super.init()
        self.reConnectTime = 0
        self.isActiveClose = false
        self.sendDataArray = NSMutableArray()
    }
    
    func connect(urlString:String) {
        close()
        self.socketStatus = .WebSocketStatusConnect
        webSocketTask = urlSession.webSocketTask(with: URL(string: urlString)!)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    func close(){
        self.socketStatus = .WebSocketStatusDisConnect
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    private func receiveMessage() {
        webSocketTask?.receive {[weak self] result in
            switch result {
                case .failure(let error):
                    print("Error in receiving message: \(error)")
                case .success(.string(let str)):
                    DispatchQueue.main.async{
                        if let receiveMessage = self?.socketDidReceiveMessage {
                            receiveMessage(str)
                        }
                    }
                    self?.receiveMessage()
                    
                default:
                    print("default")
            }
        }
    }
}

extension SocketService{
    func didReceiveMessage(_ closure:@escaping socketDidReceiveMessageClosure) {
        self.socketDidReceiveMessage = closure
    }
}
