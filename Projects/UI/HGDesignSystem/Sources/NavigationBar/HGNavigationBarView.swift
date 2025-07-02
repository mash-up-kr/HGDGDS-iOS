//
//  HGNavigationBarView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/22/25.
//

import SwiftUI

struct HGNavigationBarView<L: View, R: View>: View {
    let title: String
    @ViewBuilder let leftButtonView: L?
    @ViewBuilder let rightButtonView: R?
    private var titlePadding: CGFloat {
        let padding: CGFloat = 16
        let iconWidth: CGFloat = 24
        return iconWidth + padding * 2
    }
    
    init(
        title: String = "",
        @ViewBuilder leftButtonView: () -> L = { EmptyView() },
        @ViewBuilder rightButtonView: () -> R = { EmptyView() }
    ) {
        self.title = title
        self.leftButtonView = leftButtonView()
        self.rightButtonView = rightButtonView()
    }
    
    var body: some View {
        ZStack {
            Text(title)
                .lineLimit(1)
                .setTypo(.body_16_bold)
                .foregroundStyle(.gray100Black)
                .padding(.horizontal, titlePadding)
            HStack {
                leftButtonView
                Spacer()
                rightButtonView
            }
        }
        .frame(height: UIConstant.navigationBarHeight)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        HGNavigationBarView(title: "타이틀 입니다 어디까지 늘어나나")
        HGNavigationBarView(
            title: "타이틀 입니다 어디까지 늘어나나가나다라마바사아",
            leftButtonView: { Text("왼쪽") },
            rightButtonView: { Text("오른쪽") }
        )
        HGNavigationBarView(
            title: "타이틀 입니다 어디까지 늘어나나가나",
            rightButtonView: { Text("오른쪽") }
        )
        HGNavigationBarView(
            title: "타이틀 입니다 어디까지 ",
            leftButtonView: { HGIcons.close.image }
        )
    }
}
