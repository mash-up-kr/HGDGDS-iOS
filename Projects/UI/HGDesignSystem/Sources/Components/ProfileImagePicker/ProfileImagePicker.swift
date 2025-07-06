//
//  ProfileImagePicker.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/22/25.
//

import SwiftUI
import NukeUI
import Nuke

public protocol ProfileImagePickable: Identifiable {
    var id: String { get }
    var imageUrl: String { get }
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
            LazyImage(url: .init(string: selectedItem?.imageUrl ?? "")) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .scaledToFit()
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
                                LazyImage(url: .init(string: item.imageUrl)) { state in
                                    if let image = state.image {
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(thumbnailSize)
                                    } else {
                                        HGColors.opacityBlack10.color
                                    }
                                }
                                .setRadius(24)
                            }
                            .frame(thumbnailSize)
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
            .init(id: "1", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "2", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "3", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "4", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
            .init(id: "5", imageUrl: "https://i.pinimg.com/236x/34/ee/4d/34ee4d418a30e5ca3faf307386591fa7.jpg"),
        ]
    }
    ProfileImagePicker(itemList: items, selectedItem: $selectedItem)
}

private struct StubProfileInfo: ProfileImagePickable, Equatable {
    var id: String
    var imageUrl: String
}
