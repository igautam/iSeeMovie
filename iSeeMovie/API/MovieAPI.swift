//
//  MovieAPI.swift
//  iSeeMovies
//
//  Created by Tais on 7/10/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum MovieAPI: APIRouter {
    case getMovieDetail(Int)
    case getMovieBasedOnTypes(String,Int)
    case getMovieCredit(Int)
    
    var endpoint: (path: String, parameters: [String : Any]?, method: HTTPMethod, encoding: ParameterEncoding, headers: [String : String]?, baseURL: String) {
        switch self {
        case .getMovieDetail(let movieId):
            return ("/movie/\(movieId)",nil, .get, URLEncoding.default, nil, baseURL)
        case .getMovieBasedOnTypes(let types, let pageNo):
            return ("\(types)",["language":"en-US","region":regionCode,"page":pageNo], .get, URLEncoding.default, nil, baseURL)
        case .getMovieCredit(let movieId):
            return ("/movie/\(movieId)/credits",nil, .get, URLEncoding.default, nil, baseURL)
            
        }
    }
}


extension NetworkService {
    func getMovieDetail(movieId: Int) async throws -> MovieModel {
        let req = MovieAPI.getMovieDetail(movieId)
        return try await networkManager.request(uRLRequest: req, responseType: MovieModel.self)
    }
    func getMovieBasedOnTypes(movieTypes: String, withPageNo pageNo: Int) async throws -> PaginatedResponse<MovieModel> {
        let req = MovieAPI.getMovieBasedOnTypes(movieTypes, pageNo)
        return try await networkManager.request(uRLRequest: req, responseType: PaginatedResponse<MovieModel>.self)
    }
    
    func getMovieCredit(movieID: Int) async throws -> MovieCredit {
        let req = MovieAPI.getMovieCredit(movieID)
        return try await networkManager.request(uRLRequest: req, responseType: MovieCredit.self)
    }
}
