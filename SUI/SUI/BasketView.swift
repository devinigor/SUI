//
//  BasketView.swift
//  SUI
//
//  Created by Игорь Девин on 06.05.2024.
//

import SwiftUI

struct BasketView: View {
    @EnvironmentObject var paymentViewModel: PaymentViewModel
    @State private var isShowAlert = false
    var body: some View {
        VStack{
            Text("You choosed")
            Text("Please check and pay the selected tariff")
            if let item = paymentViewModel.selectedItems {
                CardBusketView(vpnItem: item) {
                    isShowAlert.toggle()
                }.alert("Поздравляем", isPresented: $isShowAlert) {
                    
                } message: {
                    Text("Ваш тариф \(item.title)")
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    TabBarMainView()
        .preferredColorScheme(.dark)
}

struct CardBusketView: View {
    // MARK: - Constants
    private enum Constants {
        static let calendarImage = "calendar"
        static let buttonTitle = "Buy"
    }
    let vpnItem: VPNModel
    let actionHandler: () -> ()
    var body: some View {
        VStack{
            HStack {
                ZStack{
                    Image(Constants.calendarImage)
                        .frame(width: 120, height: 120)
                    Text(String(vpnItem.days))
                        .padding(.top)
                        .font(.title)
                        .foregroundStyle(.black)
                }
                Text(vpnItem.title)
                    .frame(width: 179, height: 120)
                    .lineLimit(2)
                    .padding(.trailing, 59)
            }
            Spacer()
                .frame(height: 70)
            Button {
                actionHandler()
            } label: {
                Text(Constants.buttonTitle)
                    .padding()
                    .frame(width: 350)
                    .background(Color.blue)
                    .tint(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
