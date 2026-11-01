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
                .font(.system(size: 36, weight: .light, design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(foregroundColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .buttonStyle(CalculatorButtonStyle())
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

struct CalculatorButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1)
            .opacity(configuration.isPressed ? 0.8 : 1)
            .animation(.spring(duration: 0.2).speed(1.15), value: configuration.isPressed)
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
