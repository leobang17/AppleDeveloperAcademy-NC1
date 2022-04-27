//
//  Button.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct ButtonView: View {
    let name: String;
    let targetStatus: AuthState;
    @EnvironmentObject var authState: AuthStates;
    
    var body: some View {
        Button(name) {
            print("원래는 \(authState.state), 다음은 \(targetStatus)")
            authState.setState(targetStatus: targetStatus);
        }
    }
    
}
