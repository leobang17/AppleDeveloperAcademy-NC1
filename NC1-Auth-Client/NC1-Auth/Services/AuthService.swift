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

class AuthService {
    private static let BASE_URL: String = "http://localhost:8080/auth/"
    
    public func signIn(body: SignInRequestBody, completion: @escaping (Result<SignInData, AuthenticationError>) -> Void) {
        guard let url = URL(string: AuthService.BASE_URL + "signin") else {
            completion(.failure(.custom(errorMessage: "URL이 없음")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
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
}
