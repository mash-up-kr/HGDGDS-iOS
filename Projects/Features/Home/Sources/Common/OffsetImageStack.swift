//
//  OffsetImageStack.swift
//  HomeFeature
//
//  Created by 박병호 on 6/24/25.
//

import SwiftUI

import HGDesignSystem
import NukeUI

struct OffsetImageStack: View {
    let imageURLStrings: [String]
    let imageLength: CGFloat
    let spacing: CGFloat
    let maxVisibleCount: Int
    
    private var displayImageURLs: [URL] {
        imageURLStrings
            .compactMap { URL(string: $0) }
            .prefix(maxVisibleCount)
            .map { $0 }
    }
    
    private var totalWidth: CGFloat {
        let imageCount = displayImageURLs.count
        return imageLength + spacing * CGFloat(imageCount - 1)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            ForEach(Array(displayImageURLs.enumerated().reversed()), id: \.offset) { index, url in
                LazyImage(url: url) { state in
                    if let image = state.image {
                        image
                            .resizable()
                    } else if state.error != nil {
                        HGColors.opacityBlack10.color
                    } else {
                        HGColors.opacityBlack10.color
                    }
                }
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
        imageURLStrings: [
            "https://i.pravatar.cc/150?img=4",
            "https://i.pravatar.cc/300",
            "https://i.pravatar.cc/150?img=3",
            "https://picsum.photos/200/300?grayscale",
            "https://picsum.photos/200/300?grayscale"
        ],
        imageLength: 26,
        spacing: 20,
        maxVisibleCount: 3
    )
}
