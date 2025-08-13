//
//  APIRouter.swift
//  iSeeMovies
//
//  Created by Tais on 7/4/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Alamofire

protocol APIRouter : URLRequestConvertible {
    
    var endpoint: (
        path: String
        ,    parameters: [String: Any]?
        ,    method: Alamofire.HTTPMethod
        ,    encoding: Alamofire.ParameterEncoding
        ,    headers: [String: String]?
        ,    baseURL: String
        ){
        get
    }
    
}


extension APIRouter {
    
    func asURLRequest() -> URLRequest
    {
        var e = endpoint
        if e.parameters == nil {
            e.parameters = ["api_key":apiKey]
        } else {
           e.parameters!["api_key"] = apiKey
        }
        var request = URLRequest(url: URL(string:e.baseURL)!.appendingPathComponent(e.path))
        request.httpMethod = e.method.rawValue
        if let headers = e.headers {
            for (headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        return try! e.encoding.encode(request, with: e.parameters)
    }
    
    var baseURL: String {
        return Environment.current.baseURL
    }
    
    var apiKey: String {
        return "c5b952eaa394e8f87c92654aefde03a4"
    }
    
    var regionCode: String {
        return ConfigurationManager.sharedInstance.getSelectedCountry()
    }

}
