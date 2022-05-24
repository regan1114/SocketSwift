//
//  DataViewModel.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import Foundation

protocol DataViewModel: AnyObject {
    associatedtype ViewModel
    
    func update(_ viewModel:ViewModel)
}
