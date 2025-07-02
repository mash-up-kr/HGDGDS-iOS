//
//  HGDividerView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/22/25.
//

import SwiftUI

public struct HGDividerView: View {
    public init() { }
    
    public var body: some View {
        HGColors.gray15.color
            .frame(height: 1)
    }
}

#Preview {
    HGDividerView()
}
