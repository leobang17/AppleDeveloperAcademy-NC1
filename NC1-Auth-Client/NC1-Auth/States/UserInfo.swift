//
//  UserInfo.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/05/02.
//

import Foundation

class UserInfo: ObservableObject {
    let username: String
    let email: String
    let userId: String
    
    init() {
        let userDefaults = UserDefaults.standard
        self.username = userDefaults.string(forKey: UserDefaultEnv.username.getEnv)!
        self.email = userDefaults.string(forKey: UserDefaultEnv.email.getEnv)!
        self.userId = userDefaults.string(forKey: UserDefaultEnv.id.getEnv)!
    }
    
    public func signUp() {
        
    }
}
