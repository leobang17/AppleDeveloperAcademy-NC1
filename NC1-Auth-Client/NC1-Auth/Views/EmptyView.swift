//
//  EmptyView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct EmptyView: View {
    
    var body: some View {
        Text("EmptyView 입니다.")
        ButtonView(name: "idle로", targetStatus: .idle)
        ButtonView(name: "visitor로", targetStatus: .visitor)
        ButtonView(name: "authenticated로", targetStatus: .authenticated)
    }
}
