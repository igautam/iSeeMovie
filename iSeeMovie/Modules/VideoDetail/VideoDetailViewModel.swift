//
//  VideoDetailViewModel.swift
//  iSeeMovie
//
//  Created by Tais on 7/18/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import PromiseKit

typealias VideoTitleCellConfig = TableCellConfigurator<VideoDetailTitleTableViewCell, MovieModel>
typealias VideoCastCrewCellConfig = TableCellConfigurator<VideoDetailCastCrewTableViewCell, MovieCredit>

class VideoDetailViewModel {
    let networkService = NetworkService()
    func fetchModelData() -> [CellConfigurator] {
        let array: [CellConfigurator] = []
        return array
    }
    var localItems: [CellConfigurator] = []
    @Published var items: [CellConfigurator] = []
    var videoDetails: MovieModel?
    
    func fetchVideoDetail(movieId: Int) {
        Task { [self] in
            do {
                let movieData = try await networkService.getMovieDetail(movieId: movieId)
                self.videoDetails = movieData
                let movieCredit = try await networkService.getMovieCredit(movieID: movieId)
                self.localItems.append(VideoTitleCellConfig.init(item: movieData))
                self.localItems.append(VideoCastCrewCellConfig.init(item: movieCredit))
                self.items.append(contentsOf: localItems)
                self.localItems.removeAll()
            } catch {
                print(error)
            }
        }
    }
//    func fetchVideoDetail(movieId: Int, success: @escaping (_ items: [CellConfigurator]) -> Void, failure: @escaping (String) -> Void) {
//        APIManager.sharedInstance.getMovieDetail(movieId: movieId).then { [weak self] movieData -> Promise<MovieCredit> in
//            self?.videoDetails = movieData
//            self?.items.append(VideoTitleCellConfig.init(item: movieData))
//            return APIManager.sharedInstance.getMovieCredit(movieID: movieData.id)
//            }.done { [weak self] movieCredit in
//                self?.items.append(VideoCastCrewCellConfig.init(item: movieCredit))
//                success((self?.items)!)
//            }.catch { (error) in
//                print("error")
//                failure(error.localizedDescription)
//        }
//    }
}
