//
//  ViewModel.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 30.10.2026.
//

import SwiftUI

@Observable
class CalculatorViewModel {
    
    // MARK: Property
    var displayText = "0"
    var expressionText = ""
    var number: Double = 0.0
    var currentOperation: Operation = .none
    var isTypingNumber = false
    
    let buttonsArray: [[CalculatorButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.three, .two, .one, .plus],
        [.zero, .decimal, .equal]
    ]
    
    // MARK: Tap Button Method
    func didTap(item: CalculatorButton) {
        switch item {
        case .plus, .minus, .multiply, .divide:
            if currentOperation != .none && isTypingNumber,
                   let currentValue = Double(displayText) {
                    let result = performOperation(currentValue)
                    displayText = formatResult(result)
                    number = result
                } else {
                    // 2. Иначе просто запомнить то, что на экране
                    number = Double(displayText) ?? 0
                }
                // 3. Запомнить новую операцию и ждать следующее число
                currentOperation = item.buttonToOperation()
                isTypingNumber = false
                expressionText = "\(displayText) \(item.rawValue)"
            
        case .equal:
            expressionText = "\(expressionText) \(displayText) ="
            if let currentValue = Double(displayText) {
                let result = performOperation(currentValue)
                displayText = formatResult(result)
                number = result
            }
            currentOperation = .none     // операция выполнена
            isTypingNumber = false
            
        case .decimal:
            if isTypingNumber {
                if !displayText.contains(".") {
                    displayText += "."
                }
            } else {
                displayText = "0."
                isTypingNumber = true
            }
            
        case .percent:
            if let currentValue = Double(displayText) {
                displayText = formatResult(currentValue / 100)
            }
        case .negative:
            if let currentValue = Double(displayText) {
                displayText = formatResult(-currentValue)
            }
        case .clear:
            displayText = "0"
            number = 0
            currentOperation = .none
            isTypingNumber = false
            expressionText = ""
        default:
            if isTypingNumber {
                  displayText += item.rawValue   // продолжаем печатать
              } else {
                  displayText = item.rawValue    // начинаем новое число с нуля
                  isTypingNumber = true
              }
        }
    }
    
    
    // MARK: Helper Calculate Method
    func performOperation(_ currentValue: Double) -> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .subtract:
            return number - currentValue
        case .multiply:
            return number * currentValue
        case .divide:
            return number / currentValue
        default:
            return currentValue
        }
    }
    
    // MARK: Remove last zero Method
    func formatResult(_ result: Double) -> String {
        return String(format: "%g", result)
    }
    
    // MARK: Size of Buttons Methods
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColums: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        let standarButtonWidth = (screenWidth - totalSpacing) / totalColums
        
        if item == .zero {
            return (standarButtonWidth * 2) + spacing
        }
        
        return (screenWidth - totalSpacing) / totalColums
    }
    
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColums: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        return (screenWidth - totalSpacing) / totalColums
    }
}

