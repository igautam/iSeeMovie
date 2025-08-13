//
//  DiscoverAPI.swift
//  iSeeMovie
//
//  Created by Tais on 7/11/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum DiscoverAPI: APIRouter {
    case getMovies([String:Any]?)
    case getTVs([String:String]?)
    
    var endpoint: (path: String, parameters: [String : Any]?, method: HTTPMethod, encoding: ParameterEncoding, headers: [String : String]?, baseURL: String) {
        switch self {
        case .getMovies(let param):
            return ("/discover/movie",param, .get, URLEncoding.default, nil, baseURL)
        case .getTVs(let param):
            return ("/discover/tv",param, .get, URLEncoding.default, nil, baseURL)
        }
    }
}


extension NetworkService {
    func discoverMovies(param: [String: Any]?) async throws -> PaginatedResponse<MovieModel> {
        let req = DiscoverAPI.getMovies(param)
        return try await networkManager.request(uRLRequest: req, responseType: PaginatedResponse<MovieModel>.self)
    }
    func discoverTVs(param: [String: String]?) async throws -> PaginatedResponse<TVModel> {
        let req = DiscoverAPI.getTVs(param)
        return try await networkManager.request(uRLRequest: req, responseType: PaginatedResponse<TVModel>.self)
    }
}
