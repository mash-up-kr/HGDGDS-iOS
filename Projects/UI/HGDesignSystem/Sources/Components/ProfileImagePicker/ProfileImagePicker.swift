//
//  ProfileImagePicker.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/22/25.
//

import SwiftUI

public protocol ProfileImagePickable: Identifiable {
    var id: String { get }
    var image: Image { get }
}

public struct ProfileImagePicker<Item: ProfileImagePickable & Equatable>: View {
    private var itemList: [Item]
    @Binding private var selectedItem: Item?
    private let thumbnailSize: CGFloat = 58
    private let thumbnailInnerPadding: CGFloat = 4
    private let thumbnailSpacing: CGFloat = 7
    
    public init(
        itemList: [Item],
        selectedItem: Binding<Item?>
    ) {
        self._selectedItem = selectedItem
        self.itemList = itemList
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            Group {
                if let image = selectedItem?.image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                    HGColors.opacityBlack10.color
                }
            }
            .frame(180)
            .setRadius(70)
            .padding(.bottom, 22)
            GeometryReader { proxy in
                ScrollView(.horizontal) {
                    HStack(spacing: thumbnailSpacing) {
                        ForEach(itemList, id: \.id) { item in
                            Button {
                                withAnimation(.spring(duration: 0.35)) { selectedItem = item }
                            } label: {
                                item.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(thumbnailSize)
                                    .setRadius(24)
                            }
                            .padding(thumbnailInnerPadding)
                            .strokeBorder(
                                item.id == selectedItem?.id ? HGColors.orange500Main.color : .clear,
                                radius: 24,
                                linewidth: 2
                            )
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .contentMargins(
                    .leading,
                    centerPadding(screenWidth: proxy.frame(in: .global).width),
                    for: .scrollContent
                )
            }
            .frame(height: thumbnailSize + thumbnailInnerPadding * 2)
        }
    }
    
    private func centerPadding(screenWidth: CGFloat) -> CGFloat {
        let width: CGFloat = (thumbnailSize + thumbnailInnerPadding * 2) * CGFloat(itemList.count)
        let spacing: CGFloat = thumbnailSpacing * CGFloat(itemList.count - 1)
        return (screenWidth - (width + spacing)) / 2
    }
}

#Preview {
    @Previewable @State var selectedItem: StubProfileInfo?
    var items: [StubProfileInfo] {
        [
            .init(id: "1", image: HGImages.pinkCard.image),
            .init(id: "2", image: HGImages.blueCard.image),
            .init(id: "3", image: HGImages.blueCard.image),
            .init(id: "4", image: HGImages.blueCard.image),
            .init(id: "5", image: HGImages.blueCard.image),
        ]
    }
    ProfileImagePicker(itemList: items, selectedItem: $selectedItem)
}

private struct StubProfileInfo: ProfileImagePickable, Equatable {
    var id: String
    var image: Image
}
