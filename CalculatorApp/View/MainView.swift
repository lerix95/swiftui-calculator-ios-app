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
        VStack(spacing: 0) {
            // MARK: Display
            VStack(alignment: .trailing, spacing: -24) {
                // Secondary text
                Text(viewModel.expressionText)
                    .font(.system(size: 28, weight: .light, design: .monospaced))
                    .foregroundStyle(.displaySecondaryText)
                    .frame(height: 36, alignment: Alignment(horizontal: .trailing, vertical: .lastTextBaseline))
                    .contentTransition(.numericText())
                    .animation(.snappy, value: viewModel.expressionText)
                
                // Primary text
                Text(viewModel.displayText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.4)
                    .foregroundStyle(Color.displayText)
                    .font(.system(size: 88, weight: .light, design: .monospaced))
                    .contentTransition(.numericText())
                    .animation(.snappy.speed(1.15), value: viewModel.displayText)
                    .frame(height: 110, alignment: Alignment(horizontal: .trailing, vertical: .lastTextBaseline))
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .bottomTrailing)
            .padding(.horizontal, 12)
            .padding(.bottom, 24)
            
                // MARK: Buttons
                Grid(horizontalSpacing: 8, verticalSpacing: 8) {
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
        .background(Color.appBackground)
        .sensoryFeedback(.selection, trigger: viewModel.displayText)
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
        .preferredColorScheme(.dark)
}
