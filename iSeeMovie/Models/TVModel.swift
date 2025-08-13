//
//  TVModel.swift
//  iSeeMovie
//
//  Created by Tais on 7/21/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

struct TVModel: Codable {
    var name = ""
    var voteCount = 0
    var id = 0
    var voteAverage = 0.0
    var popularity = 0.0
    var poster_path = ""
    var original_language = ""
    var original_name = ""
    var backdrop_path = ""
    var overview = ""
    var genre_ids: [Int]?
    var originCountry: [String]?
    var firstAirDate: String?
    
    enum CodingKeys: String, CodingKey {
        case original_name = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case name = "name"
        case voteCount = "vote_count"
        case id = "id"
        case voteAverage = "vote_average"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case original_language = "original_language"
        case backdrop_path = "backdrop_path"
        case overview = "overview"
        case genre_ids = "genre_ids"
    }
    
   
}


////
////  TVModel.swift
////  iSeeMovie
////
////  Created by Tais on 7/21/18.
////  Copyright © 2018 Tais. All rights reserved.
////
//
//import Foundation
//import ObjectMapper
//
//struct TVModel: Mappable {
//    var name = ""
//    var voteCount = 0
//    var id = 0
//    var voteAverage = 0.0
//    var popularity = 0.0
//    var poster_path = ""
//    var original_language = ""
//    var original_name = ""
//    var backdrop_path = ""
//    var overview = ""
//    var genre_ids: [Int]?
//    var originCountry: [String]?
//    var firstAirDate: String?
//    
//    init?(map: Map) {
//        
//    }
//    mutating func mapping(map: Map) {
//        if map["original_name"].isKeyPresent {
//            original_name <- map["original_name"]
//        }
//        original_name <- map["original_name"]
//        firstAirDate <- map["first_air_date"]
//        originCountry <- map["origin_country"]
//        name <- map["name"]
//        voteCount <- map["vote_count"]
//        id <- map["id"]
//        voteAverage <- map["vote_average"]
//        popularity <- map["popularity"]
//        poster_path <- map["poster_path"]
//        original_language <- map["original_language"]
//        backdrop_path <- map["backdrop_path"]
//        overview <- map["overview"]
//        genre_ids <- map["genre_ids"]
//    }
//}
