//
//  MainView.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import SwiftUI

struct MainView: View {
    
    @Environment(CalculatorViewModel.self) var viewModel
    
    private let buttonRows: [[CalculatorButton]] = [
        [.backspace, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            
            // MARK: Display
            VStack(alignment: .trailing) {
                // Текст истории операций
                Text(viewModel.expressionText)
                    .font(.system(size: 28, weight: .regular))
                    .foregroundStyle(.gray)
                
                // Главный текст
                Text(viewModel.displayText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .foregroundStyle(.white)
                    .font(.system(size: 88, weight: .light, design: .default))
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomTrailing)
            .background(Color(white: 0.15))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 12)
            
                // MARK: Buttons
                Grid(horizontalSpacing: 12, verticalSpacing: 12) {
                    ForEach(buttonRows, id: \.self) { row in
                        GridRow {
                            ForEach(row, id: \.self) { button in
                                makeButton(button)
                                    .aspectRatio(1, contentMode: .fit)
                            }
                        }
                    }
                    
                    GridRow {
                        makeButton(.zero)
                            .gridCellColumns(2)
                            .gridCellUnsizedAxes(.vertical)
                        makeButton(.decimal)
                            .aspectRatio(1, contentMode: .fit)
                        makeButton(.equal)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding(.horizontal, 12)
                .layoutPriority(1)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
    
    // MARK: Helpers
    private func makeButton(_ button: CalculatorButton) -> some View {
        CalculatorButtonView(button: button) {
            viewModel.didTap(item: button)
        }
    }
}

#Preview {
    MainView()
        .environment(CalculatorViewModel())
}
