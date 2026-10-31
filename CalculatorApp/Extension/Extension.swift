//
//  Extension.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import SwiftUI

extension Color {
    static let BlueCalc = Color("BlueCalc")
    static let GrayCalc = Color("GrayCalc")
    static let DarkGrayCalc = Color("DarkGrayCalc")
}


extension Buttons {
    func buttonToOperation() -> Operations {
        switch self {
        case .plus:
            return .adition
        case .minus:
            return .substract
        case .multiple:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
}
