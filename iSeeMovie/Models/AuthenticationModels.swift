//
//  AuthenticationModels.swift
//  iSeeMovies
//
//  Created by Tais on 7/9/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

struct CreateRequestTokenResponse: Codable {
    var success: Bool = false
    var expiresAt: String?
    var requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}



////
////  AuthenticationModels.swift
////  iSeeMovies
////
////  Created by Tais on 7/9/18.
////  Copyright © 2018 Tais. All rights reserved.
////
//
//import Foundation
//import ObjectMapper
//
//struct CreateRequestTokenResponse: Mappable {
//    var success: Bool = false
//    var expiresAt: String?
//    var requestToken: String?
//    
//    init?(map: Map) {
//    }
//    
//    mutating func mapping(map: Map) {
//        success <- map["success"]
//        expiresAt <- map["expires_at"]
//        requestToken <- map["request_token"]
//    }
//}
