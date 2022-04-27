//
//  VisitorView.swift
//  NC1-Auth
//
//  Created by Leo Bang on 2022/04/27.
//

import SwiftUI

struct VisitorView: View {
    var body: some View {
        Text("VisitorView 입니다.")
        ButtonView(name: "idle로", targetStatus: .idle)
        ButtonView(name: "visitor로", targetStatus: .visitor)
        ButtonView(name: "authenticated로", targetStatus: .authenticated)
    }
}

struct VisitorView_Previews: PreviewProvider {
    static var previews: some View {
        VisitorView()
    }
}
