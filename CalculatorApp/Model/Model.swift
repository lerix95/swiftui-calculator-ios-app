//
//  Model.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import SwiftUI

enum Operations {
    case adition, substract, multiply, divide, none
}

enum Buttons: String {
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
    case multiple = "x"
    case divide = "/"
    
    // Вазделитель
    case equal = "="
    case decimal = ","
    
    // Фодификаторы
    case percent = "%"
    case negative = "+/-"
    case clear = "AC"
    
    
    // Цвета кнопок
    var buttonsColors: Color {
        switch self {
        case .clear, .negative, .percent:
            return Color.grayCalc
        case .divide, .multiple, .minus, .plus, .equal:
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
