//
//  VpnView.swift
//  SUI
//
//  Created by Игорь Девин on 06.05.2024.
//

import SwiftUI

struct VpnView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let imageFlag = "flag"
    }
    
    @State private var isToggle = false
    var body: some View {
            VStack{
                Spacer()
                Image(Constants.imageFlag)
                Spacer()
                HStack {
                    Toggle(isOn: $isToggle, label: {})
                        .frame(width: 1)
            }
                otherInfo
                Spacer()
                Text("Service will expire after 15 days.")
                Spacer()
                    .frame(height: 20)
        }
    }
    
    private var otherInfo: some View {
        VStack(spacing: 1){
            makeOtherInfo(title: "IP Address", text: "127.0.0.1")
            makeOtherInfo(title: "Received", text: "0 MB")
            makeOtherInfo(title: "Sent", text: "0 MB")
        }
    }
    
    private func makeOtherInfo(title: String, text: String) -> some View {
        HStack{
            Text(title)
                .frame(width: 100, alignment: .leading)
            Spacer()
                .frame(width: 100)
            Text(text)
                .frame(width: 100, alignment: .trailing)
        }.padding()
    }
}

#Preview {
    VpnView()
        .preferredColorScheme(.dark)
}
