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
    
    private func emptyChecker(_ inputValue: Binding<String>) -> Bool {
        if inputValue.wrappedValue.isEmpty {
            return true
        }
        return false
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
    
    private func pwdBtnHandler(_ original: Binding<String>, _ confirm: String, _ userInput: UserInput, _ inputType: InputType) {
        if pwdIdentityCheck(original.wrappedValue, confirm) {
            userInput.signUp { result in
                switch result {
                case .success(let data):
                    data.signIn { success in
                        switch success {
                        case true:
                            DispatchQueue.main.async {
                                authState.setState(targetStatus: .authenticated)
                            }
                        case false:
                            print("이럴 수 있나?")
                        }
                    }
                case .failure(_):
                    print("회원가입 실패")
                }
            }
        }
    }
    
    private func textResolver() -> Binding<String> {
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
            InputView
        } else {
            PasswordInputView
        }
    }
    
    var InputView: some View {
        VStack {
            Text("이름은? \(userInput.username)")
            Text("이멜은? \(userInput.email)")
            Text("비번은? \(userInput.password)")
            TextField("\(inputType.rawValue)", text: textResolver())
                .disableAutocorrection(true)
            NavigationLink("다음으로", destination: navLinkResolver(inputType))
                    .disabled(emptyChecker(textResolver()))
        }
    }
    
    var PasswordInputView: some View {
        VStack {
            Text("이름은? \(userInput.username)")
            Text("이멜은? \(userInput.email)")
            Text("비번은? \(userInput.password)")
            SecureField("\(inputType.rawValue)", text: textResolver())
                .disableAutocorrection(true)
            SecureField("비밀번호를 다시 한번 입력해주세요.", text: $passwordCheckValue)
                .disableAutocorrection(true)
            
            if !pwdIdentityCheck(textResolver().wrappedValue, passwordCheckValue) {
                Text("비밀번호 확인이 다릅니다.")
            }
            
            Button(action: {
                pwdBtnHandler(textResolver(), passwordCheckValue, userInput, inputType)
            }) {
                Text("회원가입 완료")
            }
                .disabled(emptyChecker(textResolver()) || emptyChecker(passwordCheckValue))
                .disabled(!pwdIdentityCheck(textResolver().wrappedValue, passwordCheckValue))
        }
    }
}
