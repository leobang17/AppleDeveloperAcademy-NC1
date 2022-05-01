//
//  AuthDTO.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/29.
//

import Foundation

//class BaseResponse {
//    var message: String
//    var success: String
//}

struct SignInData: Codable {
    let token: String
    let id: Int
    let username: String
    let email: String
    
    public func setUserDefault() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.setValue(self.token, forKey: UserDefaultEnv.token.getEnv)
        userDefaults.setValue(self.id, forKey: UserDefaultEnv.id.getEnv)
        userDefaults.setValue(self.username, forKey: UserDefaultEnv.username.getEnv)
        userDefaults.setValue(self.email, forKey: UserDefaultEnv.email.getEnv)
    }
    
    public func deleteUserDefault() {
        
    }
}

struct SignInDto: Codable {
    let message: String;
    let success: String;
    let data: SignInData?;
}
