//
//  AuthState.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import Foundation

enum AuthState {
    case idle, visitor, authenticated
}

class AuthStates: ObservableObject {
    @Published var state: AuthState = .idle
    
    init() {
        initState()
    }
    
    public func setState(targetStatus: AuthState) -> Void {
        self.state = targetStatus;
    }
    
    private func initState() {
        switch isLoggedIn() {
        case true:
            self.state = .authenticated
        case false:
            self.state = .visitor
        }
    }
    
    private func isLoggedIn() -> Bool {
        guard UserDefaults.standard.string(forKey: "jsonwebtoken") != nil else {
            print("로그인 안되어있음")
            return false;
        }
        print("로그인 되어있음")
        return true;
    }
}
