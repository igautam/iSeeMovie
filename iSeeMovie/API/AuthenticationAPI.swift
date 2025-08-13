//
//  AuthenticationAPI.swift
//  iSeeMovies
//
//  Created by Tais on 7/7/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

enum AuthenticationAPI: APIRouter {
    case createRequestToken
    case createSession(String)
    case createGuestSession
    
    
    var endpoint: (path: String, parameters: [String : Any]?, method: HTTPMethod, encoding: ParameterEncoding, headers: [String : String]?, baseURL: String) {
        switch self {
        case .createRequestToken:
            return ("/authentication/token/new",nil, .get, URLEncoding.default, nil, baseURL)
        case .createSession(let requestToek):
            return ("/authentication/session/new",["request_token": requestToek], .get, URLEncoding.default, nil, baseURL)
        case .createGuestSession:
            return ("/authentication/guest_session/new",nil, .get, URLEncoding.default, nil, baseURL)
        }
    }
}

extension NetworkService {
    func createRequestToken() async throws -> CreateRequestTokenResponse {
        let req = AuthenticationAPI.createRequestToken
        return try await networkManager.request(uRLRequest: req, responseType: CreateRequestTokenResponse.self)
    }
}
