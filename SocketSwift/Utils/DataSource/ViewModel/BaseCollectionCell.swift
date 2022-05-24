//
//  BaseCollectionCell.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import Foundation
import UIKit

class BaseCollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(){
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
