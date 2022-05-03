//
//  LoginModalView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct LoginModalView: View {
    @Binding var loginModal: Bool;
    @EnvironmentObject var authState: AuthStates;
    @StateObject var signInInput: SignInInput = SignInInput();
    @State private var showSigninAlert: Bool = false;
    
    
    var body: some View {
        Color.white
        NavigationView {
            VStack {
                TextField("Username", text: $signInInput.username)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    
                SecureField("Password", text: $signInInput.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                Button(action: {
                    loginModal = false
                }) {
                    Text("뒤로가기")
                }
                
                Button(action: {
                    signinBtnHandler()
                }) {
                    Text("로그인")
                }
                .alert(isPresented: $showSigninAlert) {
                    Alert(title: Text("로그인 실패!"), message: Text("로그인에 실패했습니다."), dismissButton: .default(Text("Dismiss")))
                }
                NavigationLink("회원가입", destination: UserInputView(userInput: UserInput(), inputType: .Username))
            }
        }
                
    }
    
    private func signinBtnHandler() {
        signInInput.signIn { success in
            switch success {
            case true:
                DispatchQueue.main.async {
                    authState.setState(targetStatus: .authenticated)
                }
            case false:
                DispatchQueue.main.async {
                    showSigninAlert.toggle()
                }
                print("로그인 실패!")
            }
            
        }
    }
}
