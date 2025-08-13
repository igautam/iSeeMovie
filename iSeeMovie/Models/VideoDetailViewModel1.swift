//
//  VideoDetailViewModel.swift
//  iSeeMovies
//
//  Created by Himanshu Juneja on 05/07/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

struct VideoDetailModel : Codable {
    var adult = false
    var backdrop_path : String?
    var name : String?
    var poster_path : String?
    var original_title : String?
    var overview : String?
    var title : String?
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdrop_path = "backdrop_path"
        case name = "name"
        case poster_path = "poster_path"
        case original_title = "original_title"
        case overview = "overview"
        case title = "title"
    }
    
}
//import ObjectMapper
//
//struct VideoDetailModel : Mappable {
//    var adult = false
//    var backdrop_path : String?
//    var name : String?
//    var poster_path : String?
//    var original_title : String?
//    var overview : String?
//    var title : String?
//
//
//    init?(map:Map) {
//        
//    }
//    mutating func mapping(map:Map){
//        adult <- map["adult"]
//        backdrop_path <- map["backdrop_path"]
//        name <- map["name"]
//        poster_path <- map["poster_path"]
//        original_title <- map["original_title"]
//        overview <- map["overview"]
//        title <- map["title"]
//    }
//    
//}


struct VideoDetailCellDataModel {
    var cellIdentifier :String = ""
    var data :BaseViewModel?
}

struct VideoTitleViewViewModel1:BaseViewModel {
    var model :VideoDetailModel?
    func fetchModelData() {
        print("Fetch Title View Data")
        
    }
}

struct VideoDetailOverViewViewModel:BaseViewModel {
    var model :VideoDetailModel?
    func fetchModelData() {
        print("Fetch Title View Data")
    }
}

class VideoDetailViewModel1 {
    var videoDetailModel : VideoDetailModel?
    
    func fetchVideoDetail(completion : @escaping ((Bool)) -> ()) {
        
    }
}
