//
//  MainView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct MainView: View {
    @StateObject var userInfo: UserInfo = UserInfo()
    @EnvironmentObject var authStates: AuthStates;
    
    var body: some View {
        Group {
            Text("유저 id: \(userInfo.userId)")
            Text("유저 이름: \(userInfo.username)")
            Text("유저 이메일: \(userInfo.email)")
            
            Text("MainView 입니다.")
            Button(action: {
                let authService = ServiceDI.getInstance
                authService.signOut()
                DispatchQueue.main.async {
                    authStates.setState(targetStatus: .visitor)
                }
            }) {
                Text("로그아웃")
            }
        }.environmentObject(userInfo)
    }
}
