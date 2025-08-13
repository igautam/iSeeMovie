//
//  Configuration.swift
//  iSeeMovies
//
//  Created by Tais on 7/7/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

enum PosterSizes: Int {
    case w92 = 0, w154, w185,w342,w500, w780, wOriginal
}

enum BackdropSizes: Int {
    case w300 = 0, w780, w1280, wOriginal
}

enum ProfileSizes: Int {
    case w45 = 0, w185, h632, wOriginal
}

enum StillSizes: Int {
    case w92 = 0, w185, w300, wOriginal
}


class ConfigurationManager {
    static var sharedInstance = ConfigurationManager()
    var configurationModel: ConfigurationModel?
    private let networkServie = NetworkService()
    
    var imageURL: String? {
        return configurationModel?.images?.baseUrl
    }
    var currentCountryIndex = 0
    
    private var countries: [CountryModel] = []
    
    private init() {
        //fetchConfiguration()
    }
    
//    func fetchConfiguration(success: @escaping () -> Void) {
//        let apiManager = APIManager.sharedInstance
//        _ = apiManager.fetchConfiguration().done { [weak self] configurationResponse in
//            self?.configurationModel = configurationResponse
//            apiManager.fetchCountries().done { (countryArray) in
//                self?.countries = countryArray
//                success()
//                }.catch { (error) in
//                    print("error: \(error)")
//            }
//        }
//    }
    
    func getSecureBaseURL() -> String? {
        guard let imageModel = configurationModel?.images else { return nil }
        return imageModel.secureBaseUrl
    }
    
    func getPosterImageSize(for size: PosterSizes) -> String? {
        guard let posters = configurationModel?.images?.posterSizes else {
            return nil
        }
        if posters.count > size.rawValue {
            return posters[size.rawValue]
        }
        return nil
    }
    
    func getBackdropImageSize(for size: BackdropSizes) -> String? {
        guard let posters = configurationModel?.images?.backdropSizes else {
            return nil
        }
        if posters.count > size.rawValue {
            return posters[size.rawValue]
        }
        return nil
    }
    
    func getProfileImageSize(for size: ProfileSizes) -> String? {
        guard let profile = configurationModel?.images?.profileSizes else {
            return nil
        }
        if profile.count > size.rawValue {
            return profile[size.rawValue]
        }
        return nil
    }
    
    func getStillImageSize(for size: StillSizes) -> String? {
        guard let still = configurationModel?.images?.stillSizes else {
            return nil
        }
        if still.count > size.rawValue {
            return still[size.rawValue]
        }
        return nil
    }
    
    
    
    func getSelectedCountry() -> String {
        return "IN"
       // return countries.filter{ $0.englishName == "India" }[0].iso31661Code
    }
}
