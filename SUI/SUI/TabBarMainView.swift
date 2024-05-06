//
//  TabBarMainView.swift
//  SUI
//
//  Created by Игорь Девин on 06.05.2024.
//

import SwiftUI

struct TabBarMainView: View {
    // MARK: - Constants
    private enum Constants {
        static let vpnLabel = "VPN"
        static let purchaseLabel = "Purchase"
        static let basketLabel = "Basket"
    }
    @ObservedObject var paymentViewModel = PaymentViewModel()
    @State private var selected = 0
    var body: some View {
        TabView(selection: $selected) {
            VpnView()
                .tabItem {
                    Label(Constants.vpnLabel, systemImage: "lock.fill")
                }
                .tag(0)
            PurchaseView(selectedTabBarItem: $selected)
                .environmentObject(paymentViewModel)
                .tabItem {
                    Label(Constants.purchaseLabel, systemImage: "list.bullet")
                }
                .tag(1)
            BasketView()
                .environmentObject(paymentViewModel)
                .tabItem {
                    Label(Constants.basketLabel, systemImage: "basket.fill")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBarMainView()
        .preferredColorScheme(.dark)
}
