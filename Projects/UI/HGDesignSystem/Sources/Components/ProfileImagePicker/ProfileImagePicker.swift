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
            .setRadius(180/2 - 10)
            .padding(.bottom, 22)
            ScrollView(.horizontal) {
                HStack(spacing: 7) {
                    ForEach(itemList, id: \.id) { item in
                        Button {
                            withAnimation(.spring(duration: 0.35)) { selectedItem = item }
                        } label: {
                            LazyImage(url: .init(string: item.imageUrl)) { state in
                                if let image = state.image {
                                    image.resizable()
                                        .scaledToFit()
                                } else {
                                    HGColors.opacityBlack10.color
                                }
                            }
                            .frame(58)
                            .scaledToFit()
                            .setRadius(58/2 - 3)
                            .padding(4)
                            .if(item.id == selectedItem?.id) {
                                $0.strokeBorder(
                                    HGColors.orange500Main.color,
                                    radius: 66/2 - 3,
                                    linewidth: 2
                                )
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
