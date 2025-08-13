//
//  UIImageViewExtensions.swift
//  iSeeMovie
//
//  Created by Tais on 7/13/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage


extension UIImageView {

    func setPosterImageWith(_ posterPath: String, size: String) {
        let confManager = ConfigurationManager.sharedInstance
        if let baseURL = confManager.getSecureBaseURL() {
            if let url = URL(string: "\(baseURL)\(size)\(posterPath)") {
                let placeHolder = UIImage(named: "defaultVideo")
                self.af_setImage(withURL: url, placeholderImage: placeHolder)
            }
        }
    }
    
    func setBackdropImageWith(_ backdropPath: String, size: String) {
        let confManager = ConfigurationManager.sharedInstance
        if let baseURL = confManager.getSecureBaseURL() {
            if let url = URL(string: "\(baseURL)\(size)\(backdropPath)") {
                let placeHolder = UIImage(named: "defaultVideo")
                self.af_setImage(withURL: url, placeholderImage: placeHolder)
            }
        }
    }
}
