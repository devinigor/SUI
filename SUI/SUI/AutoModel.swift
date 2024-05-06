//
//  AutoModel.swift
//  SUI
//
//  Created by Игорь Девин on 03.05.2024.
//

import Foundation

struct AutoModel: Hashable {
    let id = UUID()
    let model: String
    let price: Int
    let carImage: String
}
