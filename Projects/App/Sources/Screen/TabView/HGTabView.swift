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
    @State var tabViewManager = HGTabViewManager()
    private let coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
    
    private let tabbarHeight: CGFloat = 90
    
    var body: some View {
        TabView(selection: $selectedItem) {
            ForEach(TabItem.allCases, id: \.self) { tabItem in
                switch tabItem {
                case .home:
                    coordinatorFactory.homeCoordinatorRootView
                        .ignoresSafeArea()
                        .tag(tabItem)
                case .myPage:
                    coordinatorFactory.myPageCoordinatorRootView
                        .ignoresSafeArea()
                        .tag(tabItem)
                }
            }
        }
        .environment(tabViewManager)
        .overlay(alignment: .bottom) {
            if !tabViewManager.hiddenTabbar {
                tabBar
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - 탭바
    private var tabBar: some View {
        HStack(spacing: 52) {
            ForEach(TabItem.allCases, id: \.rawValue) { item in
                tabItemView(with: item)
                    .sensoryFeedback(.impact(weight: .light), trigger: selectedItem == item)
            }
        }
        .padding(.top, 8)
        .frame(height: tabbarHeight, alignment: .top)
        .background(.gray0White)
        .setRadius(30, corners: [.topLeft, .topRight])
        .padding(.top, 7) // 중앙 버튼 오버레이 공간 확보
        .overlay {
            centerButtonView()
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
    private func centerButtonView() -> some View {
        Button {
            // TODO: 추가 플로우 이동
        } label: {
            HGIcons.plusThick.image
                .resizable()
                .frame(24)
                .foregroundStyle(.gray0White)
                .padding(14)
                .background(HGGradient.orangeMain2)
                .clipShape(.circle)
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
