//
//  Extension+View.swift
//  SUI
//
//  Created by Игорь Девин on 08.05.2024.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
