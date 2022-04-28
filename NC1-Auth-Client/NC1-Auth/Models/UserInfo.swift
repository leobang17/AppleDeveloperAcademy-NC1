//
//  UserInfo.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import Foundation

class UserInfo: ObservableObject {
    private let username: String;
    
    init(username: String) {
        self.username = username;
    }
    
    public func getUsername() -> String {
        return self.username;
    }
}
