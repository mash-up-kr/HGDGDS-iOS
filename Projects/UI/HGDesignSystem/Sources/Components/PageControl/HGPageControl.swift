//
//  HGPageControl.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/21/25.
//

import SwiftUI


public struct HGPageControl: View {
    
    private let numberOfPages: Int
    @Binding private var currentIndex: Int
    
    public init(numberOfPages: Int, currentIndex: Binding<Int>) {
        self.numberOfPages = numberOfPages
        self._currentIndex = Binding(
            get: {
                min(max(currentIndex.wrappedValue, 0), numberOfPages - 1)
            },
            set: {
                currentIndex.wrappedValue = min(max($0, 0), numberOfPages - 1)
            }
        )
    }
    
    // MARK: - Constants
    
    private let circleSize: CGFloat = 6
    private let spacing: CGFloat = 4
    
    private let selectedColor = HGColors.orange500Main.color
    private let unselectedColor = HGColors.gray20.color
    
    
    // MARK: - Body
    
    public var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? selectedColor : unselectedColor)
                    .frame(circleSize)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: currentIndex)
    }
}

#Preview {
    @Previewable @State var currentIndex: Int = 0
    
    VStack {
        HGPageControl(numberOfPages: 6, currentIndex: $currentIndex)
        
        Button {
            currentIndex += 1
        } label: {
            Text("+")
        }
        
        Button {
            currentIndex -= 1
        } label: {
            Text("-")
        }
    }
}
