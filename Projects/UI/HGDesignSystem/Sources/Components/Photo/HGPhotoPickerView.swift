//
//  HGPhotoPickerView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/26/25.
//

import SwiftUI
import PhotosUI

public struct HGPhotoPickerView: View {
    @Binding private var selectedItems: [PhotosPickerItem]
    
    private let maxSelectCount: Int
    
    public init(
        selectedItems: Binding<[PhotosPickerItem]>,
        maxSelectCount: Int
    ) {
        self._selectedItems = selectedItems
        self.maxSelectCount = maxSelectCount
    }
    
    public var body: some View {
        PhotosPicker(
            selection: $selectedItems,
            maxSelectionCount: maxSelectCount,
            selectionBehavior: .ordered,
            matching: .images
        ) {
            VStack {
                HGIcons.camera.image
                    .resizable()
                    .frame(24)
                Text("\(selectedItems.count)/\(maxSelectCount)")
                    .setTypo(.body_14_bold)
            }
            .foregroundStyle(.gray30)
            .frame(85)
            .strokeBorder(HGColors.gray20.color, radius: 12, linewidth: 1)
        }
    }
}

public extension PhotosPickerItem {
    @MainActor
    func loadImage() async -> UIImage? {
        guard let imageData = try? await self.loadTransferable(type: Data.self),
              let uiImage = UIImage(data: imageData) else {
            return nil
        }
        
        return uiImage
    }
}
