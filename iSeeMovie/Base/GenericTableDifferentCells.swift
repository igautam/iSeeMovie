//
//  GenericTableDifferentCells.swift
//  iSeeMovie
//
//  Created by Tais on 7/20/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(data: DataType)
}
protocol CellConfigurator {
    static var reuseId: String { get }
    var cellSelectionHandler: TableItemSelectionHandlerType? {get set}
    func configure(cell: UIView)
}
class TableCellConfigurator<CellType: ConfigurableCell, DataType>: CellConfigurator where CellType.DataType == DataType, CellType: BaseTableViewCell {
    var cellSelectionHandler: TableItemSelectionHandlerType?
    
    static var reuseId: String {return String(describing: CellType.self)}
    let item: DataType
    init(item: DataType) {
        self.item = item
    }
    func configure(cell: UIView) {
        (cell as! CellType).configure(data: self.item)
    }
}
public typealias TableItemSelectionHandlerType = (IndexPath) -> Void

//UIViewController Based TabeleView Delegate and DataSource
class BaseTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var tableView: UITableView?
    
    var array: [CellConfigurator] = []
    // MARK: - Delegate
    var itemSelectionHandler: TableItemSelectionHandlerType?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.rowHeight = UITableView.automaticDimension
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = array[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)! as? BaseTableViewCell {
            cell.delegate = self as? TableCellDidSelect
            item.configure(cell: cell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let handler = itemSelectionHandler {
            handler(indexPath)
        }
    }
    
    func didSelectCellAt(indexPath: IndexPath, withItem item:CellConfigurator ) {
        
    }
}




//NSObject Based TabeleView Delegate and DataSource
class TabeleViewDelegateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var array: [CellConfigurator] = []
    // MARK: - Delegate
    var itemSelectionHandler: TableItemSelectionHandlerType?
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model:CellConfigurator = array[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: model).reuseId)!
        model.configure(cell: cell)
        return cell
    }
    
    
    //There are two approaches for item selection
    // 1. Pass item selection callback for each cell
    // 2. Pass item selection callback for TabeleViewDelegateDataSource stored in variable itemSelectionHandler
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let handler = itemSelectionHandler {
            handler(indexPath)
        }
    }
}

