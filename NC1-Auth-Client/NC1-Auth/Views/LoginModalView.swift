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
    @StateObject var signInInput: SignInInput = SignInInput();
    
    
    
    var body: some View {
        Color.white
        NavigationView {
            VStack {
                TextField("Username", text: $signInInput.username)
                SecureField("Password", text: $signInInput.password)
                Button(action: {
                    loginModal = false
                }) {
                    Text("뒤로가기")
                }
                
                Button(action: {
                    signInInput.signIn { success in
                        switch success {
                        case true:
                            DispatchQueue.main.async {
                                authState.setState(targetStatus: .authenticated)
                            }
                        case false:
                            print("로그인 실패!")
                        }
                        
                    }
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
