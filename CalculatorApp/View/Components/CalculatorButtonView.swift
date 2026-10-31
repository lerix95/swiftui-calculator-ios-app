//
//  CalculatorButtonView.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 31.10.2026.
//

import SwiftUI

struct CalculatorButtonView: View {
    let button: CalculatorButton
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            label
                .font(.system(size: 36, weight: .light, design: .default))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(foregroundColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 17))
        }
    }
    
    // MARK: Style
    private var backgroundColor: Color {
        switch button.kind {
        case .digit: return .buttonDigitBackground
        case .operation: return .buttonOperationBackground
        case .function: return .buttonFunctionBackground
        }
    }
    
    private var foregroundColor: Color {
        switch button.kind {
        case .function: return .black
        default: return .white
        }
    }
    
    @ViewBuilder
    private var label: some View {
        if button == .backspace {
            Image(systemName: "delete.left.fill")
                .resizable()
                .frame(width: 34, height: 28)
        } else {
            Text(button.rawValue)
        }
    }
}

#Preview {
    HStack {
        CalculatorButtonView(button: .seven) {}
        CalculatorButtonView(button: .multiply) {}
        CalculatorButtonView(button: .backspace) {}
    }
    .frame(height: 90)
    .padding()
}
