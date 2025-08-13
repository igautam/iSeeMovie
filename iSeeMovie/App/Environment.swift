//
//  Environment.swift
//  iSeeMovies
//
//  Created by Tais on 7/4/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

enum Environment : String {
    
    case Dev = "Development"
    case QA = "QA"
    case Prod = "Production"
    
    static var current: Environment {
        if let value = Bundle.main.object(forInfoDictionaryKey: "Environment") as? String,
            let env = Environment(rawValue: value) {
            return env
        }
        
        return .QA
    }
    
    var baseURL: String {
        //TODO::Remove below line used only for stub
        switch self {
        case .Dev, .QA:
            return "https://api.themoviedb.org/3"
        case .Prod:
            return "https://api.themoviedb.org/3"
        }
    }
    
    
    var pushNotificationsEnabled: Bool {
        switch self {
        case .Dev, .QA:
            return true
        case .Prod:
            return true
        }
    }
}

