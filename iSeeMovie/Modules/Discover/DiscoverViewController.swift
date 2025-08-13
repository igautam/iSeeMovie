//
//  DiscoverViewController.swift
//  iSeeMovies
//
//  Created by Tais on 7/4/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import Combine

enum VideoType: Int {
    case Movie = 0, TV, Kids
}
class DiscoverViewController: BaseTableViewController {
    var viewModel = DiscoverViewModel()
    var cancellable = Set<AnyCancellable>()
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        ConfigurationManager.sharedInstance.fetchConfiguration { [weak self] in
//            self?.configureTable()
//        }
        configureTable()
    }
    
    func configureTable() {
        tableView?.estimatedRowHeight = 150
        tableView?.register(UINib(nibName: "DiscoverMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscoverMovieTableViewCell")
        tableView?.register(UINib(nibName: "DiscoverMovieTopTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscoverMovieTopTableViewCell")
        tableView?.register(UINib(nibName: "DiscoverTVTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscoverTVTableViewCell")
        tableView?.register(UINib(nibName: "DiscoverTVTopTableViewCell", bundle: nil), forCellReuseIdentifier: "DiscoverTVTopTableViewCell")
        viewModel.$items.sink { [self] cellConfigurator in
            DispatchQueue.main.async {
                self.array.append(contentsOf: cellConfigurator)
                self.tableView?.reloadData()
            }
        }.store(in: &cancellable)
        fetchDataWith(videoType: VideoType.Movie.rawValue)
        
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let videoDetailVC = segue.destination as? VideoDetailViewController {
            if let movieId = sender as? Int {
                videoDetailVC.movieId = movieId
            }
        }
     }
    
    func fetchDataWith(videoType: Int) {
        viewModel.clearData()
        switch videoType {
        case VideoType.Movie.rawValue:
            AppDelegate.delegate.showIndicatorView()
            Task {
                try await viewModel.fetchMovieData()
                AppDelegate.delegate.hideIndicatorView()
            }
//            viewModel.fetchMovieData(success: { [weak self] (array) in
//                AppDelegate.delegate.hideIndicatorView()
//                self?.array = array
//                self?.tableView?.reloadData()
//            }, failure: { (error) in
//                AppDelegate.delegate.hideIndicatorView()
//                print(error)
//            })
        case VideoType.TV.rawValue:
            self.array = viewModel.fetchTVData()
        case VideoType.Kids.rawValue:
            self.array = viewModel.fetchTVData()
        default: break
        }
        self.tableView?.reloadData()
    }
    
    @IBAction func selectVideoTypes(_ sender: UISegmentedControl) {
        fetchDataWith(videoType: sender.selectedSegmentIndex)
    }
}



extension DiscoverViewController: TableCellDidSelect {
    //Show Selected Movie Details
    func didSelectWithMovieId(movieId: Int) {
        let stortyboard = UIStoryboard(name: "VideoDetail", bundle: nil)
        if let vc: VideoDetailViewController = stortyboard.instantiateInitialViewController() as? VideoDetailViewController {
            vc.movieId = movieId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
