//
//  CarViewModel.swift
//  SUI
//
//  Created by Игорь Девин on 03.05.2024.
//

import Foundation

final class CarViewModel: ObservableObject {
    var cars: [AutoModel] = [.init(model: "C5", price: 2_189_900, carImage: "c5"),
                             .init(model: "S5", price: 1_889_900, carImage: "s5"),
                             .init(model: "S5 GT", price: 2_189_900, carImage: "s5gt")]
}
