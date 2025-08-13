//
//  BaseViewModel.swift
//  iSeeMovies
//
//  Created by Tais on 7/10/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Base Cell View Model

protocol BaseCellViewModel {
    var row: Int { get set }
    func fetchData(succes: @escaping (Int) -> Void)
}

protocol BaseViewModel {
    func fetchModelData()
}

protocol BaseTableViewModel {
    var items: [CellConfigurator] { get set }
    func fetchModelData() -> [CellConfigurator]
}


protocol TableCellDidSelect {
    func didSelectWithMovieId(movieId: Int)
}
class BaseTableViewCell: UITableViewCell {
    var delegate: TableCellDidSelect?
    var cellSelection: TableItemSelectionHandlerType?
}
