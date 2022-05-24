//
//  ViewController.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView:UITableView!
    var dataSource:DataSource!
    var items:[CellConfiguratorType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initView()
        configureDataSource()
        addObservers()
        
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    //當應用程式由Inactive變為Active時會被呼叫。
    @objc func applicationDidBecomeActive(notification:NSNotification){
        loadData()
    }
    //當應用程式由Active變為Background時會被呼叫。
    @objc func applicationDidEnterBackground(notification:NSNotification) {
        closeSocket()
    }
    
    func initView(){
        self.view.backgroundColor = .white
        
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: AppColor.White01)
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top).offset(0)
            }
            make.left.right.equalToSuperview()
        }
    }
    
    func loadData(){
        let socketService = SocketService.shared
        socketService.connect(urlString: RESTfulConfig.Socket_URL)
        socketService.didReceiveMessage { results in
            let dictionary = self.convertToDictionary(text: results)
            let message = dictionary!["data"] as! [String : Any];
            self.webSocketDidReceiveMessage(message: message)
        }
    }
    
    func closeSocket(){
        SocketService.shared.close()
    }
    
    func webSocketDidReceiveMessage(message:[String:Any]) {
        let item = TransactionItem.init(dictionary: message)
        
        self.items.insert(CellConfigurator<SocketDataCell>(viewModel: item), at: 0)
        if(self.items.count >= 40){
            self.items.removeLast()
        }
        self.dataSource.configureItems(self.items)
        self.tableView.reloadData()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func configureDataSource(){
        dataSource = DataSource()
        
        dataSource.configureTableViewDidSelected{ (item) in
            
        }
        
        dataSource.configureCell{ (cell, item, indexPath) in
            
        }
        
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableView.automaticDimension;
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
    }
}

