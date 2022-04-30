//
//  SignInInput.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/30.
//

import Foundation

struct SignInRequestBody: Codable {
    var username: String;
    var password: String;
    init(signInInput: SignInInput) {
        self.username = signInInput.username
        self.password = signInInput.password
    }
}

class SignInInput: ObservableObject {
    @Published var username: String = "";
    @Published var password: String = "";
    
    public func signIn(completion: @escaping (Bool) -> Void) {
        let authService = AuthService()
        let body = SignInRequestBody(signInInput: self)
        
    

        authService.signIn(body: body) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                return
            case .success(let data):
                data.setUserDefault()
                completion(true)
                return
            }
        }
    }

}

