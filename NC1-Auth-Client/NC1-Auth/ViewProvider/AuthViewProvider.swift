//
//  AuthViewProvider.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct AuthViewProvider: View {
    @StateObject var authState = AuthStates();
    
    var body: some View {
        Group {
            switch authState.state {
                case .idle:
                    EmptyView()
                case .authenticated:
                    MainView()
                case .visitor:
                    VisitorView()
            }
        }.environmentObject(authState)
        
    }
}
