//
//  MovieCollectionViewModel.swift
//  iSeeMovie
//
//  Created by Tais on 7/15/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

enum TVAPIType: String {
    case TV
    case PopularTV
    case TopRatedTV
    case OnTv
    case AiringTodayTV
}

enum TVItemType { case MovieUrl, MovieId }

class TVCollectionViewModel {
    let networkService = NetworkService()
    var items: [TVModel]
    var tvAPIType: String = ""
    var title: String = ""
    var row: Int = 0
    var pageNo: Int = 1
    var paginatedResponse: PaginatedResponse<TVModel>?
    
    init(tvAPIType: TVAPIType) {
        self.items = []
       
        switch tvAPIType {
        case .TV:
            self.tvAPIType = "/discover/tv"
        case .PopularTV:
            self.tvAPIType = "/tv/popular"
            self.title = "Popular TV Shows"
        case .TopRatedTV:
            self.tvAPIType = "/tv/top_rated"
            self.title = "Top Rated TV Shows"
        case .OnTv:
            self.tvAPIType = "/tv/on_the_air"
            self.title = "Currently Airing TV Shows"
        case .AiringTodayTV:
            self.tvAPIType = "/tv/airing_today"
            self.title = "TV Shows Airing Today"
        }
    }
    
    func fetchModelData(success: @escaping (_ movieModels: [TVModel]?) -> Void) {
        Task { [self] in
            do {
                let paginatedResponse = try await networkService.getTVBasedOnTypes(tvTypes: tvAPIType, withPageNo: pageNo)
                self.paginatedResponse = paginatedResponse
                self.pageNo += 1
                guard let tvs = paginatedResponse.results else {
                    return success(nil)
                }
                self.items.append(contentsOf: tvs)
            } catch {
                
            }
        }
        
//        APIManager.sharedInstance.getTVBasedOnTypes(tvTypes: tvAPIType, withPageNo: pageNo).done { [weak self] paginatedResponse in
//            self?.paginatedResponse = paginatedResponse
//            self?.pageNo += 1
//            guard let tvs = paginatedResponse.results else {
//                return success(nil)
//            }
//            self?.items.append(contentsOf: tvs)
//            return success(self?.items)
//            }.catch { (error) in
//                print("error: \(error)")
//        }
    }
    
    //"year":"2018",
    func discoverUpComingMoviesCurrentYear() {
        Task { [self] in
            do {
                let paginatedResponse = try await networkService.discoverTVs(param: ["sort_by": "vote_average.desc"])
                if let movies = paginatedResponse.results {
                    self.items = movies
                }
            } catch {
                
            }
        }
    }

    func getMovieIdForMovieAtRow(_ row: Int) -> Int {
        if row < items.count {
            return items[row].id
        }
        return -1
    }
    
}
