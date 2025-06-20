//
//  ImageSwipeView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/19/25.
//

import SwiftUI

public struct ImageSwipeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var currentIndex: Int
    private let images: [UIImage]
    
    public init(showIndex: Int, images: [UIImage]) {
        self._currentIndex = State(initialValue: showIndex)
        self.images = images
    }
    
    public var body: some View {
        ZStack {
            HGImageViewer(currentIndex: $currentIndex, images: images)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        // TODO: 닫기아이콘이 들어가야합니다
                        Text("닫기")
                    }
                    Spacer()
                    Text("\(currentIndex + 1)/\(images.count)")
                        .foregroundStyle(.blue) // TODO: 디자인컬러 해야함 
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
                Spacer()
            }
        }
    }
}

#Preview {
    ImageSwipeView(showIndex: 1, images: [.actions, .checkmark, .remove])
}
