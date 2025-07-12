//
//  ReservationResultShareView.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/30/25.
//

import SwiftUI
import HGDesignSystem
import ReservationHistoryDomain
import UserDomain
import HGCommon
import ReservationHistoryFeatureInterface
import ReservationDomain

struct ReservationResultShareView: View {
    @State private var viewModel: ReservationResultShareViewModel
    @State private var isHiddenNavigationBar = true
    @Environment(\.openURL) private var openURL
    @Environment(HGTabViewManager.self) var tabManager
 
    private let innerPadding: CGFloat = 16
    private let outsidePadding: CGFloat = 16
    private let photoSpacing: CGFloat = 8
    private var photoGridSize: CGFloat {
        let padding: CGFloat = outsidePadding + innerPadding
        let spacing: CGFloat = photoSpacing
        return ((UIWindow.current?.screen.bounds.width ?? 300) - (padding + spacing) * 2) / 3
    }
    
    init(reservationID: Int, category: ReservationCategoryType) {
        self._viewModel = State(initialValue: .init(reservationID: reservationID, category: category))
    }
    
    var body: some View {
        contentView
            .applyNavigationBar(
                title: "",
                isHiddenBackground: isHiddenNavigationBar,
                backgroundColor: .ultraThinMaterial,
                leftButtonType: .whiteBack
            )
            .environment(\.colorScheme, .dark)
            .fullScreenCover(isPresented: $viewModel.state.isPresentedPhotoDetail) {
                if let selectedPhotoIndex = viewModel.selectedPhotoIndex {
                    ImageSwipeView(
                        showIndex: selectedPhotoIndex,
                        images: viewModel.reservationPhotoImages
                    )
                }
            }
            .onAppear {
                viewModel.reduce(.onAppear)
                tabManager.setTabBarHidden(true)
            }
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
        .background(viewModel.category.background)
    }
    
    @ViewBuilder
    private func profileImageView(profileType: ProfileType?) -> some View {
        if let profileType {
            profileType.image
                .resizable()
                .frame(62)
                .strokeBorder(
                    HGColors.gray0White.color,
                    radius: 24,
                    linewidth: 2
                )
        }
    }
    
    private var reservationTitleSectionView: some View {
        VStack(spacing: 20) {
            HGTagView(
                style: .medium,
                title: viewModel.category.title,
                textColor: .gray10,
                backgroundColor: .opacityWhite10
            )
            VStack(spacing: 0) {
                Text(viewModel.reservationTitle)
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.gray0White)
                HStack(spacing: 2) {
                    HGIcons.calendar.image
                        .resizable()
                        .frame(16)
                        .foregroundStyle(.opacityWhite30)
                    Text(viewModel.reservationDateString)
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.opacityWhite60)
                    HGIcons.timer.image
                        .resizable()
                        .frame(16)
                        .foregroundStyle(.opacityWhite30)
                    Text(viewModel.reservationTimeString)
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.opacityWhite60)
                }
            }
        }
        .background(alignment: .top) {
            viewModel.category.image
                .resizable()
                .frame(354)
                .offset(y: -13)
        }
    }
    
    @ViewBuilder
    private func profileSectionView(isShared: Bool) -> some View {
        makeSectionCardView(icon: .person, title: "내 프로필") {
            HStack(spacing: 12) {
                profileImageView(profileType: viewModel.myProfileType)
                Text(viewModel.myName)
                    .setTypo(.body_16_bold)
                    .foregroundStyle(.gray95)
                Spacer()
                
                if let userResult = viewModel.userResult {
                    let routeModel = viewModel.makeRouteModel(result: userResult)
                    NavigationLink(value: ReservationHistoryRoute.resultDetail(routeModel)) {
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
                    }
                } else {
                    NavigationLink(
                        value: ReservationHistoryRoute.resultInput(
                            reservationID: viewModel.reservationID
                        )
                    ) {
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
    
    @ViewBuilder
    private var togetherTeamSectionView: some View {
        if viewModel.memberResults.isNotEmpty {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 2) {
                    HGIcons.group.image
                        .resizable()
                        .frame(18)
                        .foregroundStyle(.gray80)
                    Text("함께하는 팀원")
                        .setTypo(.subTitle_18_bold)
                        .foregroundStyle(.gray95)
                    Text("\(viewModel.memberResults.count)명")
                        .setTypo(.subTitle_18_bold)
                        .foregroundStyle(.orange500Main)
                    Spacer()
                    Button {
                        viewModel.reduce(.didTapRefreshMemberResult)
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
                    ForEach(viewModel.memberResults.indices, id: \.self) { index in
                        let model = viewModel.memberResults[index]
                        makeTeamMemberResultView(result: model)
                    }
                }
            }
            .fillMaxWidth()
            .padding(.horizontal, innerPadding)
            .padding(.top, 14)
            .padding(.bottom, 16)
            .background(.gray0White)
            .setRadius(28)
        }
    }
    
    @ViewBuilder
    private func makeTeamMemberResultView(result: ReservationResult) -> some View {
        let routeModel = viewModel.makeRouteModel(result: result)
        NavigationLink(value: ReservationHistoryRoute.resultDetail(routeModel)) {
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
                        profileImageView(profileType: result.profileType)
                        Text(result.name)
                            .setTypo(.body_16_bold)
                            .foregroundStyle(.gray95)
                    }
                    .padding(.top, 17)
                    .padding(.horizontal, 12)
                }
            }
            .frame(height: 138)
            .overlay(alignment: .top) {
                makeResultBubbleView(type: result.resultType)
                    .shadow(
                        color: HGColors.gray100Black.color.opacity(0.07),
                        radius: 4
                    )
            }
        }
        .disabled(result.resultType == nil || result.resultType == .fail)
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
    
    @ViewBuilder
    private var linkSectionView: some View {
        if viewModel.reservationURL.isNotEmpty {
            makeSectionCardView(icon: .link, title: "링크") {
                Button {
                    if let url = URL(string: viewModel.reservationURL) {
                        openURL(url)
                    }
                } label: {
                    HStack(spacing: 4) {
                        HGIcons.linkURL.image
                            .resizable()
                            .foregroundStyle(.gray70)
                            .frame(24)
                        Text(viewModel.reservationURL)
                            .lineLimit(1)
                            .setTypo(.body_16_bold)
                            .foregroundStyle(.gray80)
                    }
                    .fillMaxWidth()
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .strokeBorder(HGColors.gray20.color, radius: 14)
                }
            }
        }
    }
    
    @ViewBuilder
    private var sharedPhotosSectionView: some View {
        if viewModel.reservationPhotoImages.isNotEmpty {
            makeSectionCardView(icon: .cameraShare, title: "공유된 사진") {
                HStack(spacing: photoSpacing) {
                    ForEach(viewModel.reservationPhotoImages.indices, id: \.self) { index in
                        Image(uiImage: viewModel.reservationPhotoImages[index])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(photoGridSize)
                            .strokeBorder(HGColors.gray20.color, radius: 16, linewidth: 1)
                            .onTapGesture {
                                viewModel.reduce(.didTapPhotoImage(index: index))
                            }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var descriptionSectionView: some View {
        if viewModel.description.isNotEmpty {
            makeSectionCardView(icon: .writePencilCircle, title: "설명") {
                Text(viewModel.description)
                    .setTypo(.body_16_regular)
                    .foregroundStyle(.gray80)
            }
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
