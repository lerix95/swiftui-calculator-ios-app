//
//  Model.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import SwiftUI

enum Operation {
    case addition, subtract, multiply, divide, none
}

enum CalculatorButton: String {
    // Цифры
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
    
    // Операции
    case plus = "+"
    case minus = "-"
    case multiply = "x"
    case divide = "/"
    
    // Разделитель
    case equal = "="
    case decimal = ","
    
    // Модификаторы
    case percent = "%"
    case negative = "+/-"
    case clear = "AC"
    
    
    // Цвета кнопок
    var buttonsColors: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color.grayCalc
        case .divide, .multiply, .minus, .plus, .equal:
            return Color.blueCalc
        default:
            return Color.darkGrayCalc
        }
    }
    
    // Цвета текста кнопок
    var textButtonsColors: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color.black
        default:
            return Color.white
        }
    }
}
