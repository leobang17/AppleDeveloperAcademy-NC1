//
//  ServiceDI.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/05/01.
//

import Foundation

class ServiceDI {
    public static let getInstance = ServiceDI().getService()
    
    private func getService() -> AuthService {
        return AuthService(getCustomRequest())
    }
    private func getCustomRequest() -> CustomRequest {
        return CustomRequest()
    }
    
    private init() {}
}
