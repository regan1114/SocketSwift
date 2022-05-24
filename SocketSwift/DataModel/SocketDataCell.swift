//
//  SocketDataCell.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import Foundation
import UIKit
import SnapKit

class SocketDataCell:BaseTableViewCell {
    var timeLabel:UILabel!
    var priceLabel:UILabel!
    var contentLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func initView() {
        self.contentView.snp.makeConstraints { (make) in
            make.height.equalTo(44)
            make.top.bottom.left.right.equalTo(self)
        }
        
        let backView = UIView()
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(16)
            make.right.equalTo(self.contentView).offset(-16)
            make.top.equalTo(self.contentView).offset(2)
            make.bottom.equalTo(self.contentView).offset(-2)
        }
        
        timeLabel = UILabel()
        self.contentView.addSubview(timeLabel)
        
        priceLabel = UILabel()
        self.contentView.addSubview(priceLabel)
        
        contentLabel = UILabel()
        self.contentView.addSubview(contentLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(10)
            make.top.equalTo(self.contentView).offset(0)
            make.bottom.equalTo(self.contentView).offset(0)
            make.width.equalTo(80)
        }
        
        priceLabel .snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLabel.snp.right).offset(0);
            make.top.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentLabel.snp.left).offset(0);
        }

        contentLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView).offset(0);
            make.top.equalTo(self.contentView).offset(0);
            make.bottom.equalTo(self.contentView).offset(0);
            make.width.equalTo(80);
        }
    }
}

extension SocketDataCell:DataViewModel {
    typealias ViewModel = TransactionItem
    
    func update(_ viewModel: TransactionItem) {
        let date = NSDate(timeIntervalSince1970: TimeInterval(viewModel.eventUnixTime))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let strDate = dateFormatter.string(from: date as Date)
        
        self.timeLabel.text = "\(strDate)";
        self.priceLabel.text = "$ \(String(format: "%.2f", viewModel.price))"
        self.contentLabel.text = "數量 \(String(format: "%.2f", viewModel.quantity))"
        let colorString = viewModel.isSellOrder ? AppColor.Green01 : AppColor.Red01
        self.contentView.backgroundColor = UIColor.init(hex: colorString)
    }
}
