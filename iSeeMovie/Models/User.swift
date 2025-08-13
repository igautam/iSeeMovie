//
//  User.swift
//  iSeeMovies
//
//  Created by Tais on 7/8/18.
//  Copyright © 2018 Tais. All rights reserved.
//

import Foundation

class User {
    static var sharedInstance = User()
    private let sessionIdKey = "session_id"
    
    private init() {
        
    }
    
    var sessionId: String? {
        get {
            return UserDefaults.standard.string(forKey: sessionIdKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: sessionIdKey)
        }
    }
    
    func loggedIn(_ sessionID: String) {
        reset()
        self.sessionId = sessionID
    }
    
    func logout() {
        reset()
    }
    
    func isUserLoggedIn() -> Bool {
        return User.sharedInstance.sessionId != nil
    }
    
    func reset() {
        UserDefaults.standard.removeObject(forKey: sessionIdKey)
    }
}
