//
//  VisitorView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct VisitorView: View {
    @State private var loginModal = false;
    
    var body: some View {
        ZStack {
            VStack {
                Button("Login") {
                    loginModal = true;
                }
                Button("OAuth1") {
                    let service = ServiceDI.getInstance
                    service.kakao { result in
                        if result {
                            print("성공")
                        } else {
                            print("실패")
                        }
                        
                    }
                    print("oauth1 누름")
                }
                Button("OAuth2") {
                    print("OAuth2 누름")
                }
            }
            
            if (loginModal) {
                LoginModalView(loginModal: $loginModal)
                    .zIndex(99)
            }
            
                
        }
        ButtonView(name: "idle로", targetStatus: .idle)
//        ButtonView(name: "visitor로", targetStatus: .visitor)
//        ButtonView(name: "authenticated로", targetStatus: .authenticated)
    }
}

struct VisitorView_Previews: PreviewProvider {
    static var previews: some View {
        VisitorView()
    }
}
