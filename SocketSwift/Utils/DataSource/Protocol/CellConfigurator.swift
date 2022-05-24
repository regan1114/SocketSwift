//
//  CellConfigurator.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import Foundation

protocol CellConfiguratorType {
    var reuseIdentifier: String{get}
    var cellClass :AnyClass {get}
    func updateCell(_ cell:BaseTableViewCell)
    func cellViewModel() -> Any
}

struct CellConfigurator<Cell> where Cell: DataViewModel, Cell: BaseTableViewCell {
    
    let viewModel: Cell.ViewModel
    let reuseIdentifier: String = NSStringFromClass(Cell.self)
    let cellClass: AnyClass = Cell.self
    
    func updateCell(_ cell: BaseTableViewCell) {
        if let cell = cell as? Cell {
            cell.update(viewModel)
        }
    }
    
    func cellViewModel() -> Any {
        return viewModel
    }
}

extension CellConfigurator: CellConfiguratorType {
    
}

struct TagCellConfigurator<Cell> where Cell: DataViewModel, Cell: BaseTableViewCell {
    
    let viewModel: Cell.ViewModel
    let reuseIdentifier: String = NSStringFromClass(Cell.self)
    let cellClass: AnyClass = Cell.self
    var tag:String!
    
    func updateCell(_ cell: BaseTableViewCell) {
        if let cell = cell as? Cell {
            cell.accessibilityLabel = tag
            cell.update(viewModel)
        }
    }
    
    func cellViewModel() -> Any {
        return viewModel
    }
}

extension TagCellConfigurator: CellConfiguratorType {
    
}

//MARK: CollectionView
protocol CollectionConfiguratorType {
    
    var reuseIdentifier: String { get }
    var cellClass: AnyClass { get }
    
    func updateCell(_ cell: BaseCollectionCell)
    
    func cellViewModel() -> Any
}

struct CollectionConfigurator<Cell> where Cell: DataViewModel, Cell: BaseCollectionCell {
    
    let viewModel: Cell.ViewModel
    let reuseIdentifier: String = NSStringFromClass(Cell.self)
    let cellClass: AnyClass = Cell.self
    
    func updateCell(_ cell: BaseCollectionCell) {
        if let cell = cell as? Cell {
            cell.update(viewModel)
        }
    }
    
    func cellViewModel() -> Any {
        return viewModel
    }
}

extension CollectionConfigurator: CollectionConfiguratorType {
    
}
