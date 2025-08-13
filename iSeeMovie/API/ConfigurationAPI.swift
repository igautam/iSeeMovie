//
//  ConfigurationAPI.swift
//  iSeeMovies
//
//  Created by Tais on 7/4/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import ObjectMapper

enum ConfigurationAPI: APIRouter {
    case getConfiguration
    case getCountries
    
    var endpoint: (path: String, parameters: [String : Any]?, method: HTTPMethod, encoding: ParameterEncoding, headers: [String : String]?, baseURL: String) {
        switch self {
        case .getConfiguration:
            return ("/configuration",nil, .get, URLEncoding.default, nil, baseURL)
        case .getCountries:
            return ("/configuration/countries",nil, .get, URLEncoding.default, nil, baseURL)
        }
    }
}

extension NetworkService {
    func fetchConfiguration() async throws -> ConfigurationModel {
        let req = ConfigurationAPI.getConfiguration
        return try await networkManager.request(uRLRequest: req, responseType: ConfigurationModel.self)
    }
    
    func fetchCountries() async throws -> [CountryModel] {
        let req = ConfigurationAPI.getCountries
        return try await networkManager.request(uRLRequest: req, responseType: [CountryModel].self)
    }
    
//    func fetchCountries(success: @escaping ([CountryModel]) -> Void, failure: @escaping (String) -> Void) {
//        APIManager.request(ConfigurationAPI.getCountries().asURLRequest()).responseData { (response) in
//            if response.response?.statusCode == 200 {
//                switch response.result {
//                case .success(let value):
//                    do {
//                        let json: Any! =  try JSONSerialization.jsonObject(with: value, options: JSONSerialization.ReadingOptions.mutableContainers)
//                        if let countryResponse = Mapper<CountryModel>().mapArray(JSONObject: json) {
//                            success(countryResponse)
//                        } else {
//                            failure("")
//                        }
//                    } catch {
//                        failure("")
//                    }
//                case .failure(let error):
//                    failure(error.localizedDescription)
//                }
//            } else {
//                failure("Error")
//            }
//        }
//    }
}
