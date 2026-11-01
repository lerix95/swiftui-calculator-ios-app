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
    
    // MARK: Tap Button Method
    func didTap(item: CalculatorButton) {
        switch item {
        case .plus, .minus, .multiply, .divide:
            if currentOperation != .none && isTypingNumber,
               let currentValue = Double(displayText) {
                
                if currentOperation == .divide && currentValue == 0 {
                    showDivisionByZeroError()
                    return
                }
                
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
                
                if currentOperation == .divide && currentValue == 0 {
                    showDivisionByZeroError()
                    return
                }
                
                let result = performOperation(currentValue)
                displayText = formatResult(result)
                number = result
            }
            currentOperation = .none
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
        case .backspace:
            if isTypingNumber {
                displayText.removeLast()
                if displayText.isEmpty || displayText == "-" {
                    displayText = "0"
                    isTypingNumber = false
                }
            } else {
                // не печатаем → полная очистка
                resetCalculator()
            }
        default:
            if isTypingNumber {
                if displayText.count < 9 {
                    displayText += item.rawValue    // продолжаем печатать
                }
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
    
    // MARK: Error Handling
    func resetCalculator() {
        displayText = "0"
        expressionText = ""
        number = 0
        currentOperation = .none
        isTypingNumber = false
    }
    
    func showDivisionByZeroError() {
        resetCalculator()
        displayText = "Division by 0"
    }
    
    // MARK: Formatting
    func formatResult(_ result: Double) -> String {
        result.formatted(
            .number
                .grouping(.never)
                .precision(.fractionLength(0...8))
                .locale(Locale(identifier: "en_US"))
        )
    }
}
