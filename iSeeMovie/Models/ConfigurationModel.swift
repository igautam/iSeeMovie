//
//  ConfigurationModel.swift
//  iSeeMovies
//
//  Created by Tais on 7/8/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

struct ConfigurationModel: Codable {
    var images: Images?
    var changeKeys: [String]?
    
    enum CodingKeys: String, CodingKey {
        case images = "images"
        case changeKeys = "change_keys"
    }
}

struct Images: Codable {
    var baseUrl: String?
    var secureBaseUrl: String?
    var backdropSizes: [String]?
    var logoSizes: [String]?
    var posterSizes: [String]?
    var profileSizes: [String]?
    var stillSizes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}

struct CountryModel: Codable {
    var iso31661Code: String = ""
    var englishName: String = ""
    
    enum CodingKeys: String, CodingKey {
        case iso31661Code = "iso_3166_1"
        case englishName = "english_name"
    }
}




////
////  ConfigurationModel.swift
////  iSeeMovies
////
////  Created by Tais on 7/8/18.
////  Copyright © 2018 Tais. All rights reserved.
////
//
//import Foundation
//import ObjectMapper
//
//
//struct ConfigurationModel: Mappable {
//    var images: Images?
//    var changeKeys: [String]?
//    
//    init?(map: Map) {
//    }
//    
//    mutating func mapping(map: Map) {
//        images <- map["images"]
//        changeKeys <- map["change_keys"]
//    }
//}
//
//struct Images:Mappable {
//    var baseUrl: String?
//    var secureBaseUrl: String?
//    var backdropSizes: [String]?
//    var logoSizes: [String]?
//    var posterSizes: [String]?
//    var profileSizes: [String]?
//    var stillSizes: [String]?
//    
//    init?(map: Map) {
//    }
//    mutating func mapping(map: Map) {
//        baseUrl <- map["base_url"]
//        secureBaseUrl <- map["secure_base_url"]
//        backdropSizes <- map["backdrop_sizes"]
//        logoSizes <- map["logo_sizes"]
//        posterSizes <- map["poster_sizes"]
//        profileSizes <- map["profile_sizes"]
//        stillSizes <- map["still_sizes"]
//    }
//}
//
//struct CountryModel: Mappable {
//    var iso31661Code: String = ""
//    var englishName: String = ""
//    
//    init?(map: Map) {
//    }
//    mutating func mapping(map: Map) {
//        iso31661Code <- map["iso_3166_1"]
//        englishName <- map["english_name"]
//        
//    }
//}
