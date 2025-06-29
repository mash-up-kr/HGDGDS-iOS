//
//  HGPhotoBox.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/28/25.
//

import SwiftUI
import PhotosUI

public struct HGPhotoBox: View {
    @State private var image: UIImage?
    private let photosPickerItem: PhotosPickerItem
    private var action: ((PhotosPickerItem)->Void)?
    
    public init(
        item: PhotosPickerItem,
        action: ((PhotosPickerItem)->Void)?
    ) {
        self.photosPickerItem = item
        self.action = action
    }
    
    public var body: some View {
        if let image {
            Image(uiImage: image)
                .resizable()
                .frame(80)
                .strokeBorder(HGColors.gray20.color, radius: 12, linewidth: 1)
                .overlay(alignment: .topTrailing) {
                    Button {
                        action?(photosPickerItem)
                    } label: {
                        HGIcons.closeInbox.image
                            .resizable()
                            .frame(24)
                    }
                    .offset(x: 9, y: -9)
                }
        } else {
            HGColors.gray15.color
                .frame(80)
                .task {
                    self.image = await photosPickerItem.loadImage()
                }
        }
    }
}
