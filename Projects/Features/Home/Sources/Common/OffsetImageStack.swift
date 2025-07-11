//
//  OffsetImageStack.swift
//  HomeFeature
//
//  Created by 박병호 on 6/24/25.
//

import SwiftUI

import UserDomain
import HGDesignSystem
import NukeUI

struct OffsetImageStack: View {
    let images: [UIImage]
    let imageLength: CGFloat
    let spacing: CGFloat
    let maxVisibleCount: Int
    
    private var totalWidth: CGFloat {
        let imageCount = images.count
        guard imageCount > 0 else { return 0 }
        return imageLength + spacing * CGFloat(imageCount - 1)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(Array(images.enumerated().reversed()), id: \.offset) { index, image in
                Image(uiImage: image)
                    .resizable()
                    .frame(imageLength)
                    .cornerRadius(imageLength / 2 - 3)
                    .offset(x: CGFloat(index) * spacing)
            }
        }
        .frame(width: totalWidth, height: imageLength, alignment: .leading)
    }
}

#Preview {
    OffsetImageStack(
        images: [
            HGImages.blueCharacter.uiImage,
            HGImages.pinkCharacter.uiImage,
            HGImages.greenCharacter.uiImage,
        ],
        imageLength: 26,
        spacing: 20,
        maxVisibleCount: 3
    )
}
