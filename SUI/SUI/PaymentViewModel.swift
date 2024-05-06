//
//  PaymentViewModel.swift
//  SUI
//
//  Created by Игорь Девин on 06.05.2024.
//

import Foundation

final class PaymentViewModel: ObservableObject {
    public var varibals: [VPNModel] = [.init(days: 7, title: "Vacation (7 days) 99 RUB"),
                                       .init(days: 30, title: "Standart (1 month) 179 RUB"),
                                       .init(days: 90, title: "Standart+ (3 month) 279 RUB")]
    @Published var selectedItems: VPNModel?
    
    func selectedItem(selectedItems: VPNModel) {
        self.selectedItems = selectedItems
    }
    
    func deleteItem() {
        self.selectedItems = nil
    }
}
