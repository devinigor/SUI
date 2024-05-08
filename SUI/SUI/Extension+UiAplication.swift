//
//  Extension+UiAplication.swift
//  SUI
//
//  Created by Игорь Девин on 08.05.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
