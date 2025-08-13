//
//  MovieModel.swift
//  iSeeMovies
//
//  Created by Tais on 7/10/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    var voteCount = 0
    var id = 0
    var isVideo = false
    var voteAverage = 0.0
    var title = ""
    var popularity = 0.0
    var poster_path = ""
    var original_language = ""
    var original_title = ""
    var backdrop_path: String?
    var adult = false
    var overview = ""
    var release_date = ""
    var genre_ids: [Int]?
    var isPostre: Bool = true
    
    var belongs_to_collection: VideoCollection?
    var budget: Int?
    var homepage: String?
    var imdb_id: String?
    var production_companies: [ProductionCompanies]?
    var production_countries: [ProductionCountry]?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages:[Language]?
    var status: String?
    var tagline: String?
    var video: Bool?
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id = "id"
        case isVideo = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case poster_path = "poster_path"
        case original_language = "original_language"
        case original_title = "original_title"
        case backdrop_path = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case release_date = "release_date"
        case genre_ids = "genre_ids"
        case belongs_to_collection = "belongs_to_collection"
        case budget = "budget"
        case homepage = "homepage"
        case imdb_id = "imdb_id"
        case production_companies = "production_companies"
        case production_countries = "production_countries"
        case revenue = "revenue"
        case runtime = "runtime"
        case spoken_languages = "spoken_languages"
        case status = "status"
        case tagline = "tagline"
       // case video
    }
}


struct VideoCollection: Codable {
    var id: Int?
    var name: String?
    var posterPath: String?
    var backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}
struct ProductionCompanies: Codable {
    var id: Int?
    var logoPath: String?
    var name: String?
    var originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
struct ProductionCountry: Codable {
    var iso_3166_1: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
    }
}

struct Language: Codable {
    var iso_639_1: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso_639_1 = "iso_639_1"
        case name = "name"
    }
}


struct MovieCredit: Codable {
    var movieId : Int?
    var casts: [Cast] = []
    var crews: [Crew] = []
    
    enum CodingKeys: String, CodingKey {
        case movieId = "cast_id"
        case casts = "cast"
        case crews = "crew"
    }
}

struct Crew: Codable {
    var credit_id : String?
    var department : String?
    var gender : Int?
    var id : Int?
    var job : String?
    var profile_path: String?
    var name : String?
    
    enum CodingKeys: String, CodingKey {
        case credit_id = "credit_id"
        case department = "department"
        case gender = "gender"
        case id = "id"
        case job = "job"
        case name = "name"
        case profile_path = "profile_path"
    }
}

struct Cast: Codable {
    var cast_id: Int?
    var credit_id: String?
    var character: String?
    var gender: Int?
    var id: Int?
    var profile_path: String?
    var name: String?
    var order: Int?
    
    enum CodingKeys: String, CodingKey {
        case cast_id = "cast_id"
        case credit_id = "credit_id"
        case character = "character"
        case gender = "gender"
        case id = "id"
        //case gender = "gender"
        case name = "name"
        case order = "order"
        case profile_path = "profile_path"
    }
}








////
////  MovieModel.swift
////  iSeeMovies
////
////  Created by Tais on 7/10/18.
////  Copyright © 2018 Tais. All rights reserved.
////
//
//import Foundation
//import ObjectMapper
//
//struct MovieModel: Mappable {
//    var voteCount = 0
//    var id = 0
//    var isVideo = false
//    var voteAverage = 0.0
//    var title = ""
//    var popularity = 0.0
//    var poster_path = ""
//    var original_language = ""
//    var original_title = ""
//    var backdrop_path = ""
//    var adult = false
//    var overview = ""
//    var release_date = ""
//    var genre_ids: [Int]?
//    var isPostre: Bool = true
//    
//    var belongs_to_collection: [VideoCollection]?
//    var budget: Int?
//    var homepage: String?
//    var imdb_id: String?
//    var production_companies: [ProductionCompanies]?
//    var production_countries: [ProductionCountry]?
//    var revenue: Int?
//    var runtime: Int?
//    var spoken_languages:[Language]?
//    var status: String?
//    var tagline: String?
//    var video: Bool?
//    
//    
//    
//    init?(map: Map) {
//        
//    }
//    mutating func mapping(map: Map) {
//        voteCount <- map["vote_count"]
//        id <- map["id"]
//        isVideo <- map["video"]
//        voteAverage <- map["vote_average"]
//        title <- map["title"]
//        popularity <- map["popularity"]
//        poster_path <- map["poster_path"]
//        original_language <- map["original_language"]
//        original_title <- map["original_title"]
//        backdrop_path <- map["backdrop_path"]
//        adult <- map["adult"]
//        overview <- map["overview"]
//        release_date <- map["release_date"]
//        genre_ids <- map["genre_ids"]
//        belongs_to_collection <- map["belongs_to_collection"]
//        budget <- map["budget"]
//        homepage <- map["homepage"]
//        imdb_id <- map["imdb_id"]
//        production_companies <- map["production_companies"]
//        production_countries <- map["production_countries"]
//        revenue <- map["revenue"]
//        runtime <- map["runtime"]
//        spoken_languages <- map["spoken_languages"]
//        status <- map["status"]
//        tagline <- map["tagline"]
//        video <- map["video"]
//    }
//}
//
//
//struct VideoCollection: Mappable {
//    var id: Int?
//    var name: String?
//    var posterPath: String?
//    var backdropPath: String?
//    
//    init?(map: Map) {
//        
//    }
//    mutating func mapping(map: Map) {
//        id <- map["id"]
//        name <- map["name"]
//        posterPath <- map["poster_path"]
//        backdropPath <- map["backdrop_path"]
//    }
//}
//struct ProductionCompanies: Mappable {
//    var id: Int?
//    var logoPath: String?
//    var name: String?
//    var originCountry: String?
//    
//    init?(map: Map) {
//        
//    }
//    mutating func mapping(map: Map) {
//        id <- map["id"]
//        name <- map["name"]
//        logoPath <- map["logo_path"]
//        originCountry <- map["origin_country"]
//    }
//}
//struct ProductionCountry: Mappable {
//    var iso_3166_1: String?
//    var name: String?
//    
//    init?(map: Map) {
//        
//    }
//    mutating func mapping(map: Map) {
//        iso_3166_1 <- map["iso_3166_1"]
//        name <- map["name"]
//    }
//}
//
//struct Language: Mappable {
//    var iso_639_1: String?
//    var name: String?
//    
//    init?(map: Map) {
//        
//    }
//    mutating func mapping(map: Map) {
//        iso_639_1 <- map["iso_639_1"]
//        name <- map["name"]
//    }
//}
//
//
//struct MovieCredit: Mappable {
//    var movieId : String?
//    var casts: [Cast] = []
//    var crews: [Crew] = []
//    
//    init?(map:Map) {
//        
//    }
//    mutating func mapping(map:Map){
//        movieId <- map["id"]
//        casts <- map["cast"]
//        crews <- map["crew"]
//    }
//}
//
//struct Crew: Mappable {
//    var credit_id : String?
//    var department : String?
//    var gender : Int?
//    var id : Int?
//    var job : String?
//    var profile_path = ""
//    var name : String?
//    
//    init?(map:Map) {
//        
//    }
//    mutating func mapping(map:Map){
//        credit_id <- map["credit_id"]
//        department <- map["department"]
//        gender <- map["gender"]
//        id <- map["id"]
//        job <- map["job"]
//        name <- map["name"]
//        profile_path <- map["profile_path"]
//    }
//}
//
//struct Cast: Mappable {
//    var cast_id : String?
//    var credit_id : String?
//    var character : String?
//    var gender : Int?
//    var id : Int?
//    var profile_path = ""
//    var name : String?
//    var order : String?
//    
//    init?(map:Map) {
//        
//    }
//    
//    mutating func mapping(map:Map){
//        cast_id <- map["cast_id"]
//        credit_id <- map["credit_id"]
//        character <- map["character"]
//        gender <- map["gender"]
//        id <- map["id"]
//        gender <- map["gender"]
//        name <- map["name"]
//        order <- map["order"]
//        profile_path <- map["profile_path"]
//    }
//}
//
