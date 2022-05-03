//
//  UserInput.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import Foundation
import CoreVideo

struct UserInputRequestBody: Codable {
    var username: String;
    var password: String;
    var email: String;

    init(_ username: String, _ password: String, _ email: String) {
        self.username = username;
        self.password = password;
        self.email = email;
    }
    
    init(userInput: UserInput) {
        self.username = userInput.username
        self.password = userInput.password
        self.email = userInput.email
    }
}

class UserInput: ObservableObject {
    @Published var username: String = "";
    @Published var password: String = "";
    @Published var email: String = "";
    
    
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
    
    public func signUp(completion: @escaping (Result<SignInInput, Error>) -> Void) {
        let authService = ServiceDI.getInstance
        let body = UserInputRequestBody(userInput: self)
        
        authService.signUp(body: body) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
