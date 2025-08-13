//
//  PaginatedResponse.swift
//  iSeeMovie
//
//  Created by Tais on 7/11/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    
    var page = 0
    var totalResults = 0
    var totalPages = 0
    var results: [T]?
    
    enum CodingKeys: String, CodingKey  {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
    
}
