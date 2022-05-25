//
//  DataSource.swift
//  SocketSwift
//
//  Created by regan on 2022/5/17.
//

import Foundation
import UIKit

class DataSource : NSObject , UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate {
    
    var items: [CellConfiguratorType] = []
    
    var isEdit:Bool = false
    var isMove:Bool = false
    
    var sectionTitles: [String] = []
    var sections: [Array<CellConfiguratorType>] = []
    
    var editIndexPaths = [NSIndexPath]()
    
    var headView:UIView?
    
    typealias configureCellBlock = (BaseTableViewCell , Any , IndexPath) -> Void
    var configureCell :configureCellBlock?
    
    typealias displayCellBlock = (BaseTableViewCell , Any , IndexPath) -> Void
    var displayCell :displayCellBlock?
    
    typealias configureCellEditBlock = (Any ,UITableViewCell.EditingStyle , IndexPath) -> Void
    var configureEditCell :configureCellEditBlock?
    
    typealias TableViewDidSelectedBlock = (Any) -> Void
    var tableViewDidSelected :TableViewDidSelectedBlock?
    
    typealias TableViewDidSelectedClosure = (BaseTableViewCell , Any , IndexPath) -> Void
    var tableViewDidSelectedClosure :TableViewDidSelectedClosure?
    
    typealias scrollViewDidScrollBlock = (_ scrollView: UIScrollView) -> Void
    var scrollBlock :scrollViewDidScrollBlock?
    
    typealias ScrollToTopBlock = (_ scrollView: UIScrollView) -> Void
    var scrollToTopBlock :ScrollToTopBlock?
    
    typealias configureHeightBlock = (UITableView , IndexPath) -> CGFloat
    var configureHeight :configureHeightBlock?
    
    typealias configureCanEditCellBlock = (UITableView , IndexPath) -> Bool
    var configureCanEditCell :configureCanEditCellBlock?
    
    typealias ScrollToBottomClosure = (_ scrollView:UIScrollView) -> Void
    var scrollToBottomClosure: ScrollToBottomClosure?
    
    override init() {
        super.init()
    }
    
    func configureRowHeight(_ block:@escaping configureHeightBlock) {
        self.configureHeight = block
    }
    
    func configureSectionTitles(_ sectionTitles:Array<String>) {
        self.sectionTitles = sectionTitles
    }
    
    func configureSections(_ sections:Array<Array<CellConfiguratorType>>) {
        self.sections = sections
    }
    
    func configureItems(_ items:Array<CellConfiguratorType> ){
        self.items = items
    }
    
    func configureHeadView(_ view:UIView)  {
        self.headView = view;
    }
    
    func registerCells(_ tableView : UITableView , cellConfigurator:CellConfiguratorType) {
        tableView.register(cellConfigurator.cellClass, forCellReuseIdentifier: cellConfigurator.reuseIdentifier)
    }
    
    func configureDisplayCell(_ block:@escaping displayCellBlock) {
        self.displayCell = block
    }
    
    func configureCell(_ block:@escaping configureCellBlock) {
        self.configureCell = block
    }
    
    func configureEditCell(_ block:@escaping configureCellEditBlock) {
        self.configureEditCell = block
    }
    
    func configureCanEditCell(_ block:@escaping configureCanEditCellBlock) {
        self.configureCanEditCell = block
    }
    
    func configureTableViewDidSelected(_ block :@escaping TableViewDidSelectedBlock ){
        self.tableViewDidSelected = block
    }
    
    func configureTableViewDidSelectedClosure(_ closure :@escaping TableViewDidSelectedClosure ){
        self.tableViewDidSelectedClosure = closure
    }
    
    func scrollBlock(_ block:@escaping scrollViewDidScrollBlock) {
        self.scrollBlock = block
    }
    
    func scrollToTopBlock(_ block:@escaping scrollViewDidScrollBlock) {
        self.scrollToTopBlock = block
    }
    
    func scrollToBottom(closure:@escaping ScrollToBottomClosure) {
        self.scrollToBottomClosure = closure
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let scrollBlock = self.scrollBlock {
            scrollBlock(scrollView)
        }
    }
    
    private func scrollViewScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let scrollToTopBlock = self.scrollToTopBlock {
            scrollToTopBlock(scrollView)
        }
        return true
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return sections.count > 0 ? sections[section].count : items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count > 0 ? sections.count : 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles.count > 0 ? sectionTitles[section] : nil
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.cellLayoutMarginsFollowReadableWidth = false
        
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        
        let cellConfigurator:CellConfiguratorType!
    
        cellConfigurator = sections.count > 0 ?
            sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] :
            items[(indexPath as NSIndexPath).row]
        
        
        if let displayCell = self.displayCell {
            displayCell(cell as! BaseTableViewCell , cellConfigurator.cellViewModel() , indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellConfigurator:CellConfiguratorType!
        if sections.count > 0 {
            cellConfigurator = sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        }else{
            cellConfigurator = items[(indexPath as NSIndexPath).row]
        }
        
        //註冊
        self.registerCells(tableView, cellConfigurator: cellConfigurator)
        
        var cell:BaseTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier) as? BaseTableViewCell
        
        if cell == nil {
            cell = BaseTableViewCell(style: .default , reuseIdentifier: cellConfigurator.reuseIdentifier)
        }
        cellConfigurator.updateCell(cell!)
        
        if let configureCell = self.configureCell {
            configureCell(cell! , cellConfigurator.cellViewModel() , indexPath)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellConfigurator:CellConfiguratorType!
        if sections.count > 0 {
            cellConfigurator = sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        }else{
            cellConfigurator = items[(indexPath as NSIndexPath).row]
        }
        
        print("didSelectRowAtIndexPath : \(cellConfigurator.cellViewModel())")
        
        if let tableViewDidSelected = self.tableViewDidSelected {
            tableViewDidSelected(cellConfigurator.cellViewModel())
        }
        
        
        if let tableViewDidSelectedClosure = self.tableViewDidSelectedClosure {
            let cell = tableView.cellForRow(at: indexPath) as! BaseTableViewCell
            tableViewDidSelectedClosure(cell , cellConfigurator.cellViewModel() , indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MAEK: 刪除 Delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if let configureCanEditCell = self.configureCanEditCell {
           return configureCanEditCell(tableView , indexPath)
        }
        
        return isEdit
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let cellConfigurator:CellConfiguratorType! = sections.count > 0 ?
        sections[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row] :
        items[(indexPath as NSIndexPath).row]
        
        if let editCell = self.configureEditCell {
            editCell(cellConfigurator.cellViewModel() , editingStyle , indexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let configureHeight = self.configureHeight {
            return configureHeight(tableView , indexPath)
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isMove
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sections.count > 0 {
            var sectionItems = sections[sourceIndexPath.section]
            let toMove = sectionItems[sourceIndexPath.row]
            sectionItems.remove(at: sourceIndexPath.row)
            sectionItems.insert(toMove, at: destinationIndexPath.row)
        }else{
            let toMove = items[sourceIndexPath.row]
            items.remove(at: sourceIndexPath.row)
            items.insert(toMove, at: destinationIndexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
        {
            if let scrollToBottomClosure = self.scrollToBottomClosure
            {
                scrollToBottomClosure(scrollView)
            }
        }
    }
}
