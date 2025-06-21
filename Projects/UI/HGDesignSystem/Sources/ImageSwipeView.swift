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
        HGImageViewer(currentIndex: $currentIndex, images: images)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        HGIcons.close.image
                            .foregroundStyle(.gray0White)
                            .frame(width: 24, height: 24)
                    }
                    Spacer()
                    Text("\(currentIndex + 1)/\(images.count)")
                        .setTypo(.body_16_bold)
                        .foregroundStyle(.gray30)
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
            }
    }
}

#Preview {
    ImageSwipeView(showIndex: 1, images: [.actions, .checkmark, .remove])
}
