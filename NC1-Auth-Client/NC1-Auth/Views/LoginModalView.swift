//
//  LoginModalView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct LoginModalView: View {
    @Binding var loginModal: Bool;
    @State var username: String = "";
    @State var password: String = "";
    @EnvironmentObject var authState: AuthStates;
    
    
    var body: some View {
        Color.white
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
                Button(action: {
                    loginModal = false
                }) {
                    Text("뒤로가기")
                }
                
                Button(action: {
                    authState.setState(targetStatus: .authenticated)
                }) {
                    Text("로그인")
                }
                NavigationLink("회원가입", destination: UserInputView(userInput: UserInput(), inputType: .Username))
            }
            

        }
                
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                VStack {
                    Text("fefefwefwe")
                }
            }
        }
    }
}


struct LoginModalView_Previews: PreviewProvider {
    static var previews: some View {
        LoginModalView(loginModal: .constant(true))
    }
}
