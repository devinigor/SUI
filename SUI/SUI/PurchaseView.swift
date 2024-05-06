//
//  PurchaseView.swift
//  SUI
//
//  Created by Игорь Девин on 06.05.2024.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject var paymentViewModel: PaymentViewModel
    @State private var isShowAlert: Bool = false
    @Binding var selectedTabBarItem: Int
    var body: some View {
        VStack{
            Text("Privacy Matters")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text("Protect your online activities with VPN Plus")
            ScrollView(showsIndicators: false){
                ForEach(paymentViewModel.varibals, id: \.self){ item in
                    CardView(isSelected: item == paymentViewModel.selectedItems, vpnItem: item, actionHandler: {
                        if item == paymentViewModel.selectedItems {
                            paymentViewModel.deleteItem()
                        } else {
                            paymentViewModel.selectedItem(selectedItems: item)
                            isShowAlert.toggle()
                        }
                    })
                }
            }.alert("Перейти в корзину?", isPresented: $isShowAlert) {
                Button("No"){}
                Button(role: .cancel, action: {
                    selectedTabBarItem = 2
                }, label: {
                    Text("Yes")
                })
            }
        }
    }
}

#Preview {
    TabBarMainView()
        .preferredColorScheme(.dark)
}


struct CardView: View {
    // MARK: - Constants
    private enum Constants {
        static let calendarImage = "calendar"
        static let buttonTitle = "Buy"
        static let addedButton = "Added"
    }
    var isSelected: Bool
    let vpnItem: VPNModel
    let actionHandler: () -> ()
    
    var body: some View {
        VStack {
            ZStack{
                Image(Constants.calendarImage)
                    .frame(width: 120, height: 120)
                Text(String(vpnItem.days))
                    .padding(.top)
                    .font(.title)
                    .foregroundStyle(.black)
            }
            Text(vpnItem.title)
            Button {
                actionHandler()
            } label: {
                Text(!isSelected ? Constants.buttonTitle : Constants.addedButton)
                    .padding()
                    .frame(width: 100)
                    .background(!isSelected ? Color.blue : Color.green.opacity(0.6))
                    .tint(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
