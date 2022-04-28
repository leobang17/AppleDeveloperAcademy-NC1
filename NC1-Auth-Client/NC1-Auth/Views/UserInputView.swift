//
//  UserInputView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

enum InputType: String {
    case Username
    case Password
    case Email
}

struct UserInputView: View {
    @StateObject var userInput: UserInput;
    @EnvironmentObject var authState: AuthStates;
    
    var inputType: InputType;
    @State var inputValue: String = "";
    @State var passwordCheckValue: String = "";
    
    
    @ViewBuilder
    private func navLinkResolver(_ inputType: InputType) -> some View {
        switch inputType {
        case .Username:
            UserInputView(userInput: userInput, inputType: .Email)
        case .Password:
            MainView()
        case .Email:
            UserInputView(userInput: userInput, inputType: .Password)
        }
    }
    
    private func emptyChecker(_ inputValue: String) -> Bool {
        if inputValue.isEmpty {
            return true
        }
        return false
    }
    
    private func pwdIdentityCheck(_ original: String, _ confirm: String) -> Bool {
        if confirm.isEmpty ||  original == confirm {
            return true
        }
        return false
    }
    
    private func pwdBtnHandler(_ original: String, _ confirm: String, _ userInput: UserInput, _ inputType: InputType) {
        if pwdIdentityCheck(original, confirm) {
            userInput.setValue(original, inputType)
            authState.setState(targetStatus: .authenticated)
            print(userInput.email)
            print(userInput.username)
            print(userInput.password)
        }
    }
    
    private func testResolver() -> Binding<String> {
        switch inputType {
        case .Username:
            return $userInput.username;
        case .Password:
            return $userInput.password;
        case .Email:
            return $userInput.email;
        }
    }
    
    var body: some View {
        if inputType != .Password {
            VStack {
                TextField("\(inputType.rawValue)", text: testResolver())
                NavigationLink("다음으로", destination: navLinkResolver(inputType))
                    .simultaneousGesture(TapGesture().onEnded {
                        userInput.setValue(inputValue, inputType)
                    })
                    .disabled(emptyChecker(inputValue))
            }
        } else {
            PasswordInputView
        }
        
    }
    
    var PasswordInputView: some View {
        VStack {
            SecureField("\(inputType.rawValue)", text: $inputValue)
            SecureField("비밀번호를 다시 한번 입력해주세요.", text: $passwordCheckValue)
            
            if !pwdIdentityCheck(inputValue, passwordCheckValue) {
                Text("비밀번호 확인이 다릅니다.")
            }
            
            Button(action: {
                pwdBtnHandler(inputValue, passwordCheckValue, userInput, inputType)
            }) {
                Text("회원가입 완료")
            }
                .disabled(emptyChecker(inputValue) || emptyChecker(passwordCheckValue))
                .disabled(!pwdIdentityCheck(inputValue, passwordCheckValue))
        }
    }
}
