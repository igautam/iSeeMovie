//
//  GenericArrayTable.swift
//  iSeeMovie
//
//  Created by Tais on 7/20/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import UIKit

//Array Table View

class ValueTableViewCell<T>: UITableViewCell {
    var value: T?
    init() {
        super.init(style: .default, reuseIdentifier: "")
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    func configure(_ item: T, at indexPath: IndexPath) {}
}


class ArrayTabeleViewDelegateDataSource<T>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var array: [T] = []
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ValueTableViewCell<T>
        cell.value = array[indexPath.row]
        return cell
    }
    
    
    //There are two approaches for item selection
    // 1. Pass item selection callback for each cell
    // 2. Pass item selection callback for TabeleViewDelegateDataSource stored in variable itemSelectionHandler
    //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let model:CellConfigurator = array[indexPath.row]
        //        model.tableItemSelectionHandler!(indexPath)
        if let handler = itemSelectionHandler {
            handler(indexPath)
        }
    }
}
