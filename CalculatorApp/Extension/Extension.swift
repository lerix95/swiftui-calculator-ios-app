//
//  Extension.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import SwiftUI

extension CalculatorButton {
    func buttonToOperation() -> Operation {
        switch self {
        case .plus:
            return .addition
        case .minus:
            return .subtract
        case .multiply:
            return .multiply
        case .divide:
            return .divide
        default:
            return .none
        }
    }
}
