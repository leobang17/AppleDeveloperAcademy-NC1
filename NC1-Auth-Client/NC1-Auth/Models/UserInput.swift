//
//  UserInput.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import Foundation

class UserInput: ObservableObject, Encodable {
    var username: String = "";
    var password: String = "";
    var email: String = "";
    
    public func setValue(_ inputValue: String , _ inputType: InputType) -> Void {
        switch inputType {
        case .Username:
            self.username = inputValue
        case .Password:
            self.password = inputValue
        case .Email:
            self.email = inputValue
        }
    }
}
