//
//  AuthenticationEnv.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/05/01.
//

import Foundation

enum UserDefaultEnv {
    case token
    case id
    case username
    case email
    
    var getEnv: String {
        switch self {
        case .token:
            return "jsonwebtoken";
        case .id:
            return "userId"
        case .username:
            return "username"
        case .email:
            return "email"
        }
    }
    
}
