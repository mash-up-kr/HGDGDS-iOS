//
//  ReservationResultShareView.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/30/25.
//

import SwiftUI
import HGDesignSystem

struct ReservationResultShareView: View {
    @Environment(\.colorScheme) var colorScheme
    private let innerPadding: CGFloat = 16
    private let outsidePadding: CGFloat = 16
    private var photoGridSize: CGFloat {
        let padding: CGFloat = outsidePadding + innerPadding
        let spacing: CGFloat = 8
        return ((UIWindow.current?.screen.bounds.width ?? 100) - (padding + spacing) * 2) / 3
    }
    @State private var isHiddenNavigationBar = true
    
    var body: some View {
        contentView
            .applyNavigationBar(
                title: "",
                isHiddenBackground: isHiddenNavigationBar,
                backgroundColor: .ultraThinMaterial,
                leftButtonType: .whiteBack
            )
            .environment(\.colorScheme, .dark)
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack {
                Spacer().frame(height: 8)
                reservationTitleSectionView
                    .onScrollVisibilityChange(threshold: 0.7) { isHiddenNavigationBar in
                        self.isHiddenNavigationBar = isHiddenNavigationBar
                    }
                Spacer().frame(height: 186)
                profileSectionView(isShared: true)
                togetherTeamSectionView
                linkSectionView
                sharedPhotosSectionView
                descriptionSectionView
            }
            .padding(.horizontal, outsidePadding)
        }
        .contentMargins(.bottom, 88)
        .background(HGGradient.purpleSub)
    }
    
    private func profileImageView() -> some View {
        Color.red.frame(62)
            .strokeBorder(
                HGColors.gray0White.color,
                radius: 24,
                linewidth: 2
            )
    }
    
    private var reservationTitleSectionView: some View {
        VStack(spacing: 20) {
            HGTagView(style: .medium, title: "액티비티", textColor: .gray10, backgroundColor: .opacityWhite10)
            VStack(spacing: 0) {
                Text("펜타포트 예매")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.gray0White)
                HStack(spacing: 2) {
                    HGIcons.calendar.image
                        .resizable()
                        .frame(16)
                        .foregroundStyle(.opacityWhite30)
                    Text("0000년 00월 00일")
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.opacityWhite60)
                    HGIcons.timer.image
                        .resizable()
                        .frame(16)
                        .foregroundStyle(.opacityWhite30)
                    Text("오후 0시")
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.opacityWhite60)
                }
            }
        }
    }
    
    private func profileSectionView(isShared: Bool) -> some View {
        makeSectionCardView(icon: .person, title: "내 프로필") {
            HStack(spacing: 12) {
                profileImageView()
                Text("이름이름")
                    .setTypo(.body_16_bold)
                    .foregroundStyle(.gray95)
                Spacer()
                Button {
                    
                } label: {
                    if isShared {
                        Text("공유한 결과 보기")
                            .setTypo(.body_14_bold)
                            .foregroundStyle(.gray95)
                            .frame(height: 31)
                            .padding(.horizontal, 10)
                            .strokeBorder(
                                HGColors.gray20.color,
                                radius: 16,
                                linewidth: 1
                            )
                    } else {
                        Text("결과 공유하기")
                            .setTypo(.body_14_bold)
                            .foregroundStyle(.gray0White)
                            .frame(height: 31)
                            .padding(.horizontal, 10)
                            .background(.orange500Main)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
    
    private var togetherTeamSectionView: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 2) {
                HGIcons.group.image
                    .resizable()
                    .frame(18)
                    .foregroundStyle(.gray80)
                Text("함께하는 팀원")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray95)
                Text("0명")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.orange500Main)
                Spacer()
                Button {
                    
                } label: {
                    HGIcons.retry.image
                        .resizable()
                        .frame(18)
                }
            }
            LazyVGrid(
                columns: [.init(), .init()],
                spacing: 6
            ) {
                makeTeamMemberView(name: "김프디1234567890", type: .success)
                makeTeamMemberView(name: "김프디", type: .ambiguousSuccess)
                makeTeamMemberView(name: "김프디", type: .fail)
                makeTeamMemberView(name: "김프디", type: nil)
            }
        }
        .fillMaxWidth()
        .padding(.horizontal, innerPadding)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .background(.gray0White)
        .setRadius(28)
    }
    
    private func makeTeamMemberView(name: String, type: ReservationResultType?) -> some View {
        Button {
            
        } label: {
            VStack {
                Spacer()
                ZStack(alignment: .top) {
                    ZStack(alignment: .bottom) {
                        HGColors.gray10.color
                            .setRadius(24)
                        HGColors.gray0White.color
                            .setRadius(22)
                            .frame(height: 78)
                            .padding(1)
                    }
                    .frame(height: 121)
                    VStack(spacing: 6) {
                        profileImageView()
                        Text(name)
                            .setTypo(.body_16_bold)
                            .foregroundStyle(.gray95)
                    }
                    .padding(.top, 17)
                    .padding(.horizontal, 12)
                }
            }
            .frame(height: 138)
            .overlay(alignment: .top) {
                makeResultBubbleView(type: type)
                    .shadow(
                        color: HGColors.gray100Black.color.opacity(0.07),
                        radius: 4
                    )
            }
        }
        .disabled(type == .fail || type == nil)
    }
    
    @ViewBuilder
    private func makeResultBubbleView(type: ReservationResultType?) -> some View {
        if let type {
            let text = Text(type.title).setTypo(.caption_12_bold)
            switch type {
            case .success, .ambiguousSuccess:
                HStack(spacing: 0) {
                    text
                        .foregroundStyle(.orange500Main)
                    type.image
                        .resizable()
                        .frame(22)
                    HGIcons.arrowRight.image
                        .resizable()
                        .frame(12)
                        .foregroundStyle(.orange400)
                }
                .frame(height: 28)
                .background {
                    HGToolTipShape()
                        .strokeBorder(HGColors.orange400.color, lineWidth: 1)
                }
                .background {
                    HGToolTipShape()
                        .foregroundStyle(.gray0White)
                }
            case .fail:
                HStack(spacing: 0) {
                    text
                        .foregroundStyle(.gray95)
                    type.image
                        .resizable()
                        .frame(22)
                }
                .frame(height: 28)
                .background {
                    HGToolTipShape()
                        .strokeBorder(HGColors.gray15.color, lineWidth: 1)
                }
                .background {
                    HGToolTipShape()
                        .foregroundStyle(.gray0White)
                }
            }
        } else {
            Text("기다리는 중...")
                .setTypo(.caption_12_medium)
                .foregroundStyle(.gray80)
                .frame(height: 28)
                .background {
                    HGToolTipShape()
                        .strokeBorder(HGColors.gray15.color, lineWidth: 1)
                }
                .background {
                    HGToolTipShape()
                        .foregroundStyle(.gray0White)
                }
        }
    }
    
    private var linkSectionView: some View {
        makeSectionCardView(icon: .link, title: "링크") {
            Button {
                
            } label: {
                HStack(spacing: 4) {
                    HGIcons.linkURL.image
                        .resizable()
                        .foregroundStyle(.gray70)
                        .frame(24)
                    Text("링크링크링크링크링크링크링클이클이큰ㅇㄹㅇㄴㄹㄴㅇㅇㄴㄹㄴㅇ")
                        .lineLimit(1)
                        .setTypo(.body_16_bold)
                        .foregroundStyle(.gray80)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .strokeBorder(HGColors.gray20.color, radius: 14)
            }
        }
    }
    
    private var sharedPhotosSectionView: some View {
        makeSectionCardView(icon: .cameraShare, title: "공유된 사진") {
            HStack(spacing: 5) {
                ForEach(0...1, id: \.self) { _ in
                    Color.red
                        .frame(photoGridSize)
                        .setRadius(16)
                        .strokeBorder(HGColors.gray20.color, radius: 16, linewidth: 1)
                }
            }
        }
    }
    
    private var descriptionSectionView: some View {
        makeSectionCardView(icon: .writePencilCircle, title: "설명") {
            Text("설명을 작성합니다설명을 작성합니다설명을 작성합니다설명을작성합니다설명을작성합니다설명을작성합니다")
                .setTypo(.body_16_regular)
                .foregroundStyle(.gray80)
        }
    }
    
    private func makeSectionCardView(
        icon: HGIcons,
        title: String,
        @ViewBuilder chlidView: () -> some View
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 2) {
                icon.image
                    .resizable()
                    .frame(18)
                    .foregroundStyle(.gray80)
                Text(title)
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray95)
            }
            chlidView()
        }
        .fillMaxWidth()
        .padding(.horizontal, innerPadding)
        .padding(.top, 16)
        .padding(.bottom, 18)
        .background(.gray0White)
        .setRadius(28)
    }
}

#Preview(traits: .applyFont) {
    ReservationResultShareView()
}
