//
//  Model.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import Foundation

enum Operation {
    case addition, subtract, multiply, divide, none
}

enum CalculatorButton: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    
    case plus = "+"
    case minus = "-"
    case multiply = "×"
    case divide = "÷"
    
    case equal = "="
    case decimal = ","
    
    case percent = "%"
    case negative = "±"
    case backspace = "⌫"
    
    var kind: ButtonKind {
        switch self {
        case .backspace, .negative, .percent:
            return .function
        case .plus, .minus, .multiply, .divide, .equal:
            return .operation
        default:
            return .digit
        }
    }
    
    enum ButtonKind {
        case digit       // цифры и точка
        case operation   // + − × ÷ =
        case function    // AC ± %
    }
}
