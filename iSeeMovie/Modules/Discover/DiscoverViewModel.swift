//
//  DiscoverViewModel.swift
//  iSeeMovie
//
//  Created by Tais on 7/11/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import UIKit
import Combine

typealias DiscoverMovieCellConfig = TableCellConfigurator<DiscoverMovieTableViewCell, MovieCollectionViewModel>
typealias DiscoverTopMovieCellConfig = TableCellConfigurator<DiscoverMovieTopTableViewCell, MovieCollectionViewModel>
typealias DiscoverTVCellConfig = TableCellConfigurator<DiscoverTVTableViewCell, TVCollectionViewModel>
typealias DiscoverTopTVCellConfig = TableCellConfigurator<DiscoverTVTopTableViewCell, TVCollectionViewModel>

class DiscoverViewModel {
    let networkServie = NetworkService()
    //var items: [CellConfigurator]
    @Published var items: [CellConfigurator] = []
    var localItems: [CellConfigurator] = []
    
    var paginatedResponse: PaginatedResponse<MovieModel>?
    
    init() {
        self.items = []
//        Task {
//            try await fetchMovieData()
//        }
    }
    
    func fetchMovieData() async throws {
        let config = try await networkServie.fetchConfiguration()
        ConfigurationManager.sharedInstance.configurationModel = config
        let movies = try await networkServie.fetchDiscoverMovies(param: ["year": "2017","sort_by": "popularity.desc","page": 1])
        let model = MovieCollectionViewModel(movieAPIType: MovieAPIType.Movies, paginatedResponse: movies)
        self.localItems.append(DiscoverTopMovieCellConfig.init(item: model))
        let popularMovies = try await networkServie.getMovieBasedOnTypes(movieTypes: "/movie/popular", withPageNo: 1)
        self.saveModelWithResponse(MovieAPIType.PopularMovies, paginatedResponse: popularMovies)
        let topRated = try await networkServie.getMovieBasedOnTypes(movieTypes: "/movie/top_rated", withPageNo: 1)
        self.saveModelWithResponse(MovieAPIType.TopRatedMovies, paginatedResponse: topRated)
        let ucoming = try await networkServie.getMovieBasedOnTypes(movieTypes: "/movie/upcoming", withPageNo: 1)
        self.saveModelWithResponse(MovieAPIType.UpComingMovies, paginatedResponse: ucoming)
        let nowPlaying = try await networkServie.getMovieBasedOnTypes(movieTypes: "/movie/now_playing", withPageNo: 1)
        self.saveModelWithResponse(MovieAPIType.NowPlayingMovies, paginatedResponse: nowPlaying)
//        let (moviesRes, popularMoviesRes, topRatedRes, ucomingRes, nowPlayingRes) = try await (movies, popularMovies, topRated, ucoming, nowPlaying)
//        self.saveModelWithResponse(MovieAPIType.Movies, paginatedResponse: moviesRes)
//        self.saveModelWithResponse(MovieAPIType.Movies, paginatedResponse: popularMoviesRes)
//        self.saveModelWithResponse(MovieAPIType.Movies, paginatedResponse: topRatedRes)
//        self.saveModelWithResponse(MovieAPIType.Movies, paginatedResponse: ucomingRes)
//        self.saveModelWithResponse(MovieAPIType.Movies, paginatedResponse: nowPlayingRes)
        print("localItems.count = \(localItems.count)")
        self.items.append(contentsOf: localItems)
        self.localItems.removeAll()
    }
//    func fetchMovieData(success: @escaping ([CellConfigurator])->Void, failure: @escaping (String) -> Void )  {
//         APIManager.sharedInstance.discoverMovies(param: ["year": "2017","sort_by": "popularity.desc","page": 1]).then { [weak self] paginatedResponse -> Promise<PaginatedResponse<MovieModel>> in
//            let model = MovieCollectionViewModel(movieAPIType: MovieAPIType.Movies, paginatedResponse: paginatedResponse)
//            self?.items.append(DiscoverTopMovieCellConfig.init(item: model))
//            return APIManager.sharedInstance.getMovieBasedOnTypes(movieTypes: "/movie/popular", withPageNo: 1)
//            }.then { [weak self] paginatedResponse -> Promise<PaginatedResponse<MovieModel>> in
//                print("Self: \(String(describing: self))")
//                self?.saveModelWithResponse(MovieAPIType.PopularMovies, paginatedResponse: paginatedResponse)
//                return APIManager.sharedInstance.getMovieBasedOnTypes(movieTypes: "/movie/top_rated", withPageNo: 1)
//            }.then { [weak self] paginatedResponse -> Promise<PaginatedResponse<MovieModel>> in
//                self?.saveModelWithResponse(MovieAPIType.TopRatedMovies, paginatedResponse: paginatedResponse)
//                return APIManager.sharedInstance.getMovieBasedOnTypes(movieTypes: "/movie/upcoming", withPageNo: 1)
//            }.then { [weak self] paginatedResponse -> Promise<PaginatedResponse<MovieModel>> in
//                self?.saveModelWithResponse(MovieAPIType.UpComingMovies, paginatedResponse: paginatedResponse)
//                return APIManager.sharedInstance.getMovieBasedOnTypes(movieTypes: "/movie/now_playing", withPageNo: 1)
//            }.done { [weak self] paginatedResponse in
//                self?.saveModelWithResponse(MovieAPIType.NowPlayingMovies, paginatedResponse: paginatedResponse)
//                success((self?.items)!)
//            }.catch { (error) in
//              failure(error.localizedDescription)
//        }
//    }
    
    func saveModelWithResponse(_ movieAPIType: MovieAPIType, paginatedResponse: PaginatedResponse<MovieModel>) {
        print("\(#function) : \(self)")
        let model = MovieCollectionViewModel(movieAPIType: movieAPIType, paginatedResponse: paginatedResponse)
        self.localItems.append(DiscoverMovieCellConfig.init(item: model))
    }
    
    
    func fetchTVData() -> [CellConfigurator] {
        var items: [CellConfigurator] = []
        items.append(DiscoverTopTVCellConfig.init(item: TVCollectionViewModel(tvAPIType: TVAPIType.TV)))
        items.append(DiscoverTVCellConfig.init(item: TVCollectionViewModel(tvAPIType: TVAPIType.PopularTV)))
        items.append(DiscoverTVCellConfig.init(item: TVCollectionViewModel(tvAPIType: TVAPIType.TopRatedTV)))
        items.append(DiscoverTVCellConfig.init(item: TVCollectionViewModel(tvAPIType: TVAPIType.OnTv)))
        items.append(DiscoverTVCellConfig.init(item: TVCollectionViewModel(tvAPIType: TVAPIType.AiringTodayTV)))
        
        self.items = items
        return items
    }
    
    func clearData() {
        self.items.removeAll()
    }
    
}
