//
//  VideoDetailViewController.swift
//  iSeeMovies
//
//  Created by Himanshu Juneja on 05/07/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import Combine

class VideoDetailViewController: BaseTableViewController {
    
    var viewModel = VideoDetailViewModel()
    var movieId: Int = 0
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MovieID: \(movieId)")
        configureTableView()
        
    }

    
    func configureTableView() {
        self.tableView?.estimatedRowHeight = 300
        self.tableView?.rowHeight = UITableView.automaticDimension
        self.tableView?.register(UINib(nibName: "VideoDetailTitleTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoDetailTitleTableViewCell")
        self.tableView?.register(UINib(nibName: "VideoDetailCastCrewTableViewCell", bundle: nil), forCellReuseIdentifier: "VideoDetailCastCrewTableViewCell")
       // AppDelegate.delegate.showIndicatorView()
        viewModel.$items.sink { [self] cellConfigurator in
            DispatchQueue.main.async {
                self.array.append(contentsOf: cellConfigurator)
                self.tableView?.reloadData()
            }
        }.store(in: &cancellable)
        viewModel.fetchVideoDetail(movieId: movieId)
        
//        viewModel.fetchVideoDetail(movieId: movieId, success: { [weak self] cellConfigurator in
//            AppDelegate.delegate.hideIndicatorView()
//            self?.array = cellConfigurator
//            self?.tableView?.reloadData()
//        }) { error in
//            AppDelegate.delegate.hideIndicatorView()
//            print(error)
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
