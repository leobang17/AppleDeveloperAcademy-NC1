//
//  CustomRequest.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/30.
//

import Foundation

enum RequestError: Error {
    case UrlNotExists, TokenNotExists
}

enum RequestType {
    case Get, Post
}

class CustomRequest {
    private static let URL_PREFIX: String = "http://localhost:8080/"
    
    public func getRequest(baseUrl: BaseUrl, endpoint: String) -> URLRequest {
        return createRequest(url: urlResolver(baseUrl, endpoint), requestType: .Get)
    }

    public func postRequest<T: Codable>(baseUrl: BaseUrl, endpoint: String, body: T?) -> URLRequest {
        var request = createRequest(url: urlResolver(baseUrl, endpoint), requestType: .Post)
        guard let body = body else {
            return request
        }
             
        request.httpBody = try? JSONEncoder().encode(body)
        return request
    }
    
    private func urlResolver(_ baseUrl: BaseUrl, _ endpoint: String) -> URL {
        return URL(string: CustomRequest.URL_PREFIX + baseUrl.url + endpoint)!
    }
    
    private func createRequest(url: URL, requestType: RequestType) -> URLRequest {
        var request = URLRequest(url: url)

        switch requestType {
        case .Get:
            request.httpMethod = "GET"
        case .Post:
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        guard let tokenRequest = embedToken(request: &request) else {
            return request
        }
        
        return tokenRequest
    }
    
    private func embedToken(request: inout URLRequest) -> URLRequest? {
        guard let token = getToken() else {
            return nil
        }
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func getToken() -> String? {
        let userDefault = UserDefaults.standard
        return userDefault.string(forKey: UserDefaultEnv.token.getEnv)
    }
    
}
