//
//  NetworkServide.swift
//  MyTheMovieDB
//
//  Created by Rajesh Kumar on 27/07/25.
//

import Alamofire
import Foundation


// MARK: - Usage Examples

class NetworkService {
    let networkManager = NetworkManager.shared
    
    func fetchDiscoverMovies(param: [String: Any]?) async throws -> PaginatedResponse<MovieModel> {
        let urlReq = DiscoverAPI.getMovies(param)
        return try await networkManager.request(uRLRequest: urlReq, responseType: PaginatedResponse<MovieModel>.self)
    }
    
    func fetchDiscoverMoviesClosure(
        param: [String: Any],
        completion:  @escaping (Result<PaginatedResponse<MovieModel>, NetworkError>) -> Void)  {
        let urlReq = DiscoverAPI.getMovies(param)
        networkManager.request(uRLRequest: urlReq, responseType: PaginatedResponse<MovieModel>.self) { result in
            completion(result)
        }
    }
    
//    func discoverTVs(param: [String: String]?) async throws -> PaginatedResponse<TVModel> {
//        let urlReq = DiscoverAPI.getTVs(param)
//        return try await networkManager.request(uRLRequest: urlReq, responseType: PaginatedResponse<TVModel>.self)
//    }
    
//    func fetchConfiguration() async throws -> ConfigurationModel {
//        let urlReq = ConfigurationAPI.getConfiguration
//        return try await networkManager.request(uRLRequest: urlReq, responseType: ConfigurationModel.self)
//    }
}

