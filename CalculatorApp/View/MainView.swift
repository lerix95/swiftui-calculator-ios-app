//
//  MainView.swift
//  CalculatorApp
//
//  Created by Valeriy Protsenko on 28.10.2026.
//

import SwiftUI

struct MainView: View {
    
    @Environment(CalculatorViewModel.self) var viewModel
    
    var body: some View {
        
        ZStack {
            // MARK: Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                Spacer()
                // MARK: Display
                VStack(alignment: .trailing) {
                    Text(viewModel.expressionText)
                        .font(.system(size: 28, weight: .regular))
                        .foregroundStyle(.gray)
                    
                    Text(viewModel.displayText)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .foregroundStyle(.white)
                        .font(.system(size: 88, weight: .light, design: .default))
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.leading, 16)
                .padding(.trailing, 28)
                
                // MARK: Buttons
                ForEach(viewModel.buttonsArray, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button {
                                viewModel.didTap(item: item)
                            } label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: viewModel.buttonWidth(item: item),
                                        height: viewModel.buttonHeight())
                                    .font(.system(size: 36, weight: .light, design: .default))
                                    .foregroundStyle(item.textButtonsColors)
                                    .background(item.buttonsColors)
                                    .clipShape(RoundedRectangle(cornerRadius: 17))
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 12)
        }
    }
    
}

#Preview {
    MainView()
        .environment(CalculatorViewModel())
}
