//
//  HGPhotoPickerView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/26/25.
//

import SwiftUI
import PhotosUI

public struct HGPhotoPickerView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @Binding private var images: [UIImage]
    private let maxSelectCount: Int
    
    public init(images: Binding<[UIImage]>, maxSelectCount: Int) {
        self._images = images
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
        .onChange(of: selectedItems) { _, newValue in
            Task {
                await loadImage(newValue)
            }
        }
    }
    
    @MainActor
    private func loadImage(_ imageItems: [PhotosPickerItem]) async {
        var tempImages: [UIImage] = []
        for imageItem in imageItems {
            guard let imageData = try? await imageItem.loadTransferable(type: Data.self),
                  let uiImage = UIImage(data: imageData) else {
                continue
            }
            tempImages.append(uiImage)
        }
        images = tempImages
    }
}

#Preview {
    @Previewable @State var images: [UIImage] = []
    
    VStack {
        HStack {
            ForEach(images.indices, id: \.self) {
                Image(uiImage: images[$0])
                    .resizable()
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
            }
        }
        HGPhotoPickerView(images: $images, maxSelectCount: 3)
    }
}
