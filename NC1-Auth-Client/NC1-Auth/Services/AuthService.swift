//
//  AuthService.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/29.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case error(error: Error)
    case custom(errorMessage: String)
}

enum SignUpError: Error {
    case userExists
    case error(error: Error)
    case custom(errorMessage: String)
}

enum BaseUrl {
    case auth
    
    var url: String {
        switch self {
        case .auth:
            return "auth/"
        }
    }
}

class AuthService {
    private let customRequest: CustomRequest;
    private let baseUrl = BaseUrl.auth
    
    public func kakao(completion: @escaping (Bool) -> Void) {
        let request = customRequest.getRequest(baseUrl: baseUrl, endpoint: "kakao")
        print(request.url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(false)
            }
            print("여기 들어옴")
            completion(true)
        }.resume()
    }
    
    public func signUp(body: UserInputRequestBody, completion: @escaping (Result<SignInInput, SignUpError>) -> Void) {
        let request = customRequest.postRequest(baseUrl: baseUrl, endpoint: "signup", body: body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.custom(errorMessage: "return value 없음")))
                return
            }
            
//            guard let loginResponse = try? JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: )
            let signInInput = self.userInputConverter(body)
            
            completion(.success(signInInput))
        }.resume()
        
    }
    
    public func signIn(body: SignInRequestBody, completion: @escaping (Result<SignInData, AuthenticationError>) -> Void) {
        let request = customRequest.postRequest(baseUrl: baseUrl, endpoint: "signin", body: body)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.custom(errorMessage: "data 못받아옴")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(SignInDto.self, from: data) else {
                completion(.failure(.custom(errorMessage: "response 를 볻받아옴")))
                return
            }
            
            guard let authData = loginResponse.data else {
                completion(.failure(.custom(errorMessage: "sign in 받아왔는데 그 안에 data property가 없음")))
                return
            }
            
            completion(.success(authData))
            
        }.resume()
    }
    
    public func signOut() {
        let userDefault = UserDefaults.standard;
        userDefault.removeObject(forKey: UserDefaultEnv.token.getEnv)
        userDefault.removeObject(forKey: UserDefaultEnv.id.getEnv)
        userDefault.removeObject(forKey: UserDefaultEnv.username.getEnv)
        userDefault.removeObject(forKey: UserDefaultEnv.email.getEnv)
    }
    
    private func userInputConverter(_ userInput: UserInputRequestBody) -> SignInInput {
        let signInInput = SignInInput()
        signInInput.username = userInput.username
        signInInput.password = userInput.password
        return signInInput
        
    }
    
    init(_ customRequest: CustomRequest) {
        self.customRequest = customRequest;
    }
}
