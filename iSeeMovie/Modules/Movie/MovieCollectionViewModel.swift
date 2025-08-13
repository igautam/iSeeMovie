//
//  MovieCollectionViewModel.swift
//  iSeeMovie
//
//  Created by Tais on 7/15/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

enum MovieAPIType: String {
    case Movies
    case PopularMovies
    case TopRatedMovies
    case UpComingMovies
    case NowPlayingMovies
}

enum MovieItemType { case MovieUrl, MovieId }

class MovieCollectionViewModel {
    let networkService = NetworkService()
    @Published var items: [MovieModel] = []
    var movieAPIType: String = ""
    var title: String = ""
    var row: Int = 0
    var pageNo: Int = 1
    var paginatedResponse: PaginatedResponse<MovieModel>? = nil
    var isLoadingPages: Bool = false
    
    init(movieAPIType: MovieAPIType, paginatedResponse: PaginatedResponse<MovieModel>) {
        self.paginatedResponse = paginatedResponse
        if let items = paginatedResponse.results {
            self.items = items
        }
        self.pageNo = 2
        switch movieAPIType {
        case .Movies:
            self.movieAPIType = "/discover/movie"
        case .PopularMovies:
            self.movieAPIType = "/movie/popular"
            self.title = "Popular Movies"
        case .TopRatedMovies:
            self.movieAPIType = "/movie/top_rated"
            self.title = "Top Rated Movies"
        case .UpComingMovies:
            self.movieAPIType = "/movie/upcoming"
            self.title = "Upcoming Movies"
        case .NowPlayingMovies:
            self.movieAPIType = "/movie/now_playing"
            self.title = "Now Playing Movies"
        }
        
    }
    
//    init(movieAPIType: MovieAPIType) {
//        self.items = []
//        switch movieAPIType {
//        case .Movies:
//            self.movieAPIType = "/discover/movie"
//        case .PopularMovies:
//            self.movieAPIType = "/movie/popular"
//            self.title = "Popular Movies"
//        case .TopRatedMovies:
//            self.movieAPIType = "/movie/top_rated"
//            self.title = "Top Rated Movies"
//        case .UpComingMovies:
//            self.movieAPIType = "/movie/upcoming"
//            self.title = "Upcoming Movies"
//        case .NowPlayingMovies:
//            self.movieAPIType = "/movie/now_playing"
//            self.title = "Now Playing Movies"
//        case .TV:
//            self.movieAPIType = "/discover/tv"
//        case .PopularTV:
//            self.movieAPIType = "/tv/popular"
//            self.title = "Popular TV Shows"
//        case .TopRatedTV:
//            self.movieAPIType = "/tv/top_rated"
//            self.title = "Top Rated TV Shows"
//        case .OnTv:
//            self.movieAPIType = "/tv/on_the_air"
//            self.title = "Currently Airing TV Shows"
//        case .AiringTodayTV:
//            self.movieAPIType = "/tv/airing_today"
//            self.title = "TV Shows Airing Today"
//        }
//    }
    
//    func fetchModelData(success: @escaping (_ movieModels: [MovieModel]?) -> Void) {
//        APIManager.sharedInstance.getMovieBasedOnTypes(movieTypes: movieAPIType, withPageNo: pageNo).done { [weak self] paginatedResponse in
//            self?.paginatedResponse = paginatedResponse
//            self?.pageNo += 1
//            guard let movies = paginatedResponse.results else {
//                return success(nil)
//            }
//            self?.items.append(contentsOf: movies)
//            print("\(self?.title ?? "") items.count: \(self?.items.count ?? 0)")
//            return success(movies)
//            }.catch { (error) in
//                print("error: \(error)")
//        }
//    }
    func fetchModelData() {
        Task { [self] in
            do {
                let paginatedResponse = try await networkService.getMovieBasedOnTypes(movieTypes: movieAPIType, withPageNo: pageNo)
                self.paginatedResponse = paginatedResponse
                self.pageNo += 1
                if let movies = paginatedResponse.results {
                    self.items.append(contentsOf: movies)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func discoverUpComingMoviesCurrentYear() {
        Task {
            do {
                let paginatedResponse = try await networkService.discoverMovies(param: ["year": "2017","sort_by": "popularity.desc","page": pageNo])
                self.paginatedResponse = paginatedResponse
                self.pageNo += 1
                if let movies = paginatedResponse.results {
                    self.items.append(contentsOf: movies)
                }
            } catch {
                print(error)
            }
        }
    }
    //"year":"2018",
//    func discoverUpComingMoviesCurrentYear(success: @escaping (_ movieModels: [MovieModel]?) -> Void) {
//        APIManager.sharedInstance.discoverMovies(param: ["year": "2017","sort_by": "popularity.desc","page": pageNo]).done { [weak self] paginatedResponse in
//            self?.paginatedResponse = paginatedResponse
//            self?.pageNo += 1
//            guard let movies = paginatedResponse.results else {
//                return success(nil)
//            }
//            self?.items.append(contentsOf: movies)
//            print("\(self?.title ?? "") items.count: \(self?.items.count ?? 0)")
//            return success(movies)
//            }.catch { (error) in
//                print("error: \(error)")
//        }
//    }

    func getMovieIdForMovieAtRow(_ row: Int) -> Int {
        if row < items.count {
            return items[row].id
        }
        return -1
    }
    
}
