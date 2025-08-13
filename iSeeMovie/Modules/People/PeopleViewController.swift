//
//  PeopleViewController.swift
//  iSeeMovies
//
//  Created by Tais on 7/10/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit



/*
class MovieDetailCell: BaseTableViewCell {
    override func bindData() {
        if let viewModel: MovieDetailViewModel = viewModel as? MovieDetailViewModel {
            print(viewModel)
        }
    }
    
}
class MovieDetailViewModel: BaseCellViewModel {
    var row: Int = 0
    var movieDetail: MovieModel?
    
    func fetchData(succes: @escaping (_ index: Int) -> Void ) {
        APIManager.sharedInstance.getMovieDetail(movieId: "284053").done { [weak self] movieDetailResponse in
            self?.movieDetail = movieDetailResponse
            if let row = self?.row {
                succes(row)
            } else {
                succes(-1)
            }
            }.catch { (error) in
                print(error)
        }
    }
}


class PeopleViewController: UIViewController {

    var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let movieDetailViewModel: MovieDetailViewModel = MovieDetailViewModel()
        movieDetailViewModel.fetchData { row in
            //reload cell with row
            self.tableView?.reloadData()
        }
        let movieDetailModel: CellDataModel = CellDataModel(cellIdentifier: "1234", data: movieDetailViewModel)
        
    
        let cell: BaseTableViewCell = tableView!.dequeueReusableCell(withIdentifier: "", for: IndexPath()) as! BaseTableViewCell
        cell.viewModel = movieDetailModel.data
        cell.bindData()
        
    }
    
}
*/
