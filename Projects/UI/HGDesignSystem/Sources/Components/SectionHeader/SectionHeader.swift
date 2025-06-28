//
//  SectionHeader.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/28/25.
//

import SwiftUI

public struct SectionHeader: View {
    private let title: String
    private let isRequired: Bool
    private let content: String?
    
    public init(
        title: String,
        isRequired: Bool = false,
        content: String? = nil
    ) {
        self.title = title
        self.isRequired = isRequired
        self.content = content
    }
    
    public var body: some View {
        HStack(spacing: .zero) {
            Text(title)
                .foregroundStyle(HGColors.gray80)
            if isRequired {
                Text("*")
                    .foregroundStyle(HGColors.orange500Main)
                    .padding(.leading, 2)
            }
            
            if let content {
                Text(content)
                    .foregroundStyle(HGColors.gray50)
                    .padding(.leading, 8)
            }
            
            Spacer()
        }
        .setTypo(.caption_12_medium)
    }
}
