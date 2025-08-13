//
//  TVAPI.swift
//  iSeeMovie
//
//  Created by Tais on 7/21/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum TVAPI: APIRouter {
    case getTVDetail(Int)
    case getTVBasedOnTypes(String,Int)
    
    var endpoint: (path: String, parameters: [String : Any]?, method: HTTPMethod, encoding: ParameterEncoding, headers: [String : String]?, baseURL: String) {
        switch self {
        case .getTVDetail(let movieId):
            return ("/tv/\(movieId)",nil, .get, URLEncoding.default, nil, baseURL)
        case .getTVBasedOnTypes(let types, let pageNo):
            return ("\(types)",["language":"en-US","region":regionCode,"page":pageNo], .get, URLEncoding.default, nil, baseURL)
        }
    }
}


extension NetworkService {
    func getTVDetail(tvId: Int) async throws -> TVModel {
        let req = TVAPI.getTVDetail(tvId)
        return try await networkManager.request(uRLRequest: req, responseType: TVModel.self)
    }
    func getTVBasedOnTypes(tvTypes: String, withPageNo pageNo: Int) async throws -> PaginatedResponse<TVModel> {
        let req = TVAPI.getTVBasedOnTypes(tvTypes, pageNo)
        return try await networkManager.request(uRLRequest: req, responseType: PaginatedResponse<TVModel>.self)
    }
}

