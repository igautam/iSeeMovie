//
//  APIError.swift
//  iSeeMovies
//
//  Created by Tais on 7/6/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Alamofire
import ObjectMapper

extension Alamofire.DataResponse {
    var apiError: NSError? {
        if let error = NSError(apiData: data, statusCode: response?.statusCode ?? -1) {
            return error
        }
        return networkError
    }
    
    var networkError: NSError? {
        if let statusCode = response?.statusCode {
            if (400..<500).contains(statusCode) {
                return NSError(domain: "com.iSeeMovies.api", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Client Error \(statusCode)"])
            }
            if (500..<600).contains(statusCode) {
                return NSError(domain: "com.iSeeMovies.api", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Server Error \(statusCode)"])
            }
        }
        
        //Handle Alamofire Error
        if let error = (result.error as? AFError)
        , error.isResponseSerializationError
        , let data = data
            , let message = String(data: data, encoding: .utf8) {
            return NSError(domain: "com.iSeeMovies.api", code: -1, userInfo: [NSLocalizedDescriptionKey: message])
        }
        
        return result.error as NSError?
    }
    
    var apiValue: Value? {
        return apiError == nil ? result.value : nil
    }
}

extension NSError {
    
    convenience init?(apiData: Data?, statusCode: Int) {
        guard let _ = apiData else {
            return nil
        }
        //Map Error as per business logic for error handling like
//        if let error = Mapper<APIResponseErrors>().map(JSONString: String(data: apiData, encoding: String.Encoding.utf8) ?? "") {
//            self.init(domain: APIResponseErrors.Domain, code: statusCode, userInfo: [
//                APIErrorsKey: error.errors.map{ NSError(apiError: $0) }
//                ,    APIErrorSuggestedAddresses: error.addressSuggestions ?? []
//                ])
//            return
//        }
        return nil
    }
}
