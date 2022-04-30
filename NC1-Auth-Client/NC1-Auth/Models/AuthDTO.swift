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
    private let USER_DEFAULT_TOKEN = "jsonwebtoken";
    private let USER_DEFAULT_ID = "user_id";
    private let USER_DEFAULT_USERNAME = "username";
    private let USER_DEFAULT_EMAIL = "email";
    
    let token: String
    let id: Int
    let username: String
    let email: String
    
    public func setUserDefault() {
        let userDefaults = UserDefaults.standard
        
        userDefaults.setValue(self.token, forKey: USER_DEFAULT_TOKEN)
        userDefaults.setValue(self.id, forKey: USER_DEFAULT_ID)
        userDefaults.setValue(self.username, forKey: USER_DEFAULT_USERNAME)
        userDefaults.setValue(self.email, forKey: USER_DEFAULT_EMAIL)
    }
    
    public func deleteUserDefault() {
        
    }
}

struct SignInDto: Codable {
    let message: String;
    let success: String;
    let data: SignInData?;
}
