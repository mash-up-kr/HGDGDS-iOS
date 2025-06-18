//
//  HGTabView.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/15/25.
//

import SwiftUI
import HGDesignSystem

struct HGTabView: View {
    @State private var selectedItem: TabItem = .home
    @State private var hidenTabbar: Bool = false
    
    var body: some View {
        VStack(spacing: .zero) {
            TabView(selection: $selectedItem) {
                ForEach(TabItem.allCases, id: \.self) { tabItem in
                    switch selectedItem {
                    case .home:
                        // TODO: Home View
//
//                        Color.blue
//                            .ignoresSafeArea()
                        HGButton(title: "테스트", size: .large, variant: .primary, isMaxWidth: false, onTap: { })
                    case .add:
                        EmptyView()
                    case .profile:
                        // TODO: Profile(MyPage) View
                        Color.green
                            .ignoresSafeArea()
                    }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if !hidenTabbar {
                tabBar
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - 탭바
    private var tabBar: some View {
        HStack(spacing: .zero) {
            ForEach(TabItem.allCases, id: \.rawValue) { item in
                if item == .add {
                    Color.clear.frame(52)
                } else {
                    tabItemView(with: item)
                        .sensoryFeedback(.impact(weight: .light), trigger: selectedItem == item)
                }
            }
        }
        .padding(.bottom, 21)
        .frame(height: 102)
        .background(.gray0White)
        .setRadius(30, corners: [.topLeft, .topRight])
        .padding(.top, 7)
        .overlay {
            centerButtonView(with: .add)
        }
        .compositingGroup()
        .shadow(
            color: HGColors.opacityBlack10.color,
            radius: 24,
            y: -4
        )
    }
    
    // MARK: - 탭 아이템 버튼
    private func tabItemView(with item: TabItem) -> some View {
        Button {
            withAnimation(.spring) {
                selectedItem = item
            }
        } label: {
            VStack(spacing: .zero) {
                if let icon = item.icon {
                    icon.image
                        .resizable()
                        .frame(24)
                }
                Text(item.title)
                    .setTypo(.caption_11_regular)
            }
            .fillMaxWidth(.center)
            .foregroundStyle(selectedItem == item ? .orange500Main : .gray40)
        }
    }
    
    // MARK: - 중앙 추가 버튼
    private func centerButtonView(with item: TabItem) -> some View {
        Button {
            // TODO: 추가 플로우 이동
        } label: {
            if let icon = item.icon {
                icon.image
                    .resizable()
                    .frame(24)
                    .foregroundStyle(.gray0White)
                    .padding(14)
                    .background(HGGradient.orangeMain2)
                    .clipShape(.circle)
            }
        }
        .padding(7)
        .background(HGColors.gray0White.color.frame(66))
        .clipShape(.circle)
        .offset(y: -34)
    }
}

#Preview {
    HGTabView()
}
