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
    @Published var state: AuthState = .idle;
    
    public func setState(targetStatus: AuthState) -> Void {
        self.state = targetStatus;
    }
}
