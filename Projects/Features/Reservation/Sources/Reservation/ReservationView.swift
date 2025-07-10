//
//  ReservationView.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import NukeUI
import HGCommon
import ReservationDomain
import UserDomain
import HGDesignSystem

struct ReservationView: View {
    @Bindable var viewModel: ReservationViewModel
    @State private var isHiddenNavigationBar = true
    
    private let innerPadding: CGFloat = 16
    private let outsidePadding: CGFloat = 16
    private var photoGridSize: CGFloat {
        let padding: CGFloat = outsidePadding + innerPadding
        let spacing: CGFloat = 8
        return ((UIWindow.current?.screen.bounds.width ?? 100) - (padding + spacing) * 2) / 3
    }
    
    init(reservationId: Int, category: ReservationCategoryType) {
        self.viewModel = .init(reservationId: reservationId, category: category)
    }
    
    var dDay: Int { viewModel.reservation.reservationDatetime?.dDayValue() ?? 0 }
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            contentView
                .applyNavigationBar(
                    title: isHiddenNavigationBar ? "" : "예약 상세",
                    isHiddenBackground: isHiddenNavigationBar,
                    backgroundColor: .ultraThinMaterial,
                    leftButtonType: .whiteBack
                )
                .colorScheme(.dark)
        }
        .onAppear {
            viewModel.reduce(.onAppear)
        }
        .fullScreenCover(isPresented: $viewModel.state.isShowImageViewer) {
            ImageSwipeView(
                showIndex: viewModel.selectedImageIndex ?? 0,
                images: viewModel.sharedImages
            )
        }
        .background(
            ActivityView(
                isPresented: $viewModel.state.isPresentedShareSheet,
                items: ["https://hgdgds.duckdns.org/invite?reservationId=\(viewModel.reservationId)"]
            )
        )
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                titleView
                    .onScrollVisibilityChange(threshold: 0.7) { isHiddenNavigationBar in
                        self.isHiddenNavigationBar = isHiddenNavigationBar
                    }
                Spacer().frame(height: 46)
                timerView
                Spacer().frame(height: 91)
                LazyVStack(spacing: 8) {
                    if !viewModel.isWithinOneHours {
                        readyTipMessage
                    }
                    profileSectionView
                    togetherTeamSectionView
                    linkSectionView
                    sharedPhotosSectionView
                    descriptionSectionView
                }
            }
            .padding(.horizontal, outsidePadding)
            .background(alignment: .top) {
                viewModel.category.image
                    .padding(.top, 109) // 라이벌 생기면 145로 변경
            }
        }
        .contentMargins(.bottom, 88)
    }
    
    private var background: some View {
        VStack(spacing: 0) {
            viewModel.category.gradient.frame(height: 637)
            HGColors.gray10.color
        }
        .ignoresSafeArea()
    }
    
    private func profileImageView(type: ProfileType) -> some View {
        type.image
            .resizable()
            .frame(62)
            .strokeBorder(
                HGColors.gray0White.color,
                radius: 24,
                linewidth: 2
            )
    }
    
    private var titleView: some View {
        VStack(spacing: 0) {
            HGTagView(
                style: .medium,
                title: viewModel.category.title,
                textColor: .gray10,
                backgroundColor: HGColors.opacityWhite10
            )
            Spacer().frame(height: 20)
            Text(viewModel.reservation.title)
                .setTypo(.display_32_extraBold)
                .foregroundStyle(.gray0White)
            HStack(spacing: 2) {
                HGIcons.calendar.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.opacityWhite30)
                Text(viewModel.reservation.reservationDatetime?.formatted(with: .yyyyMMddKorean) ?? "")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.opacityWhite60)
                HGIcons.timer.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.opacityWhite30)
                Text(viewModel.reservation.reservationDatetime?.formatted(with: .ahhmm) ?? "")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.opacityWhite60)
            }
            Spacer().frame(height: 8)
            
            //TODO: - 아래 주석은 2차 배포에 포함
//            HStack(spacing: 0) {
//                HGIcons.fire.image
//                    .resizable()
//                    .frame(18)
//                
//                Group {
//                    Text("같은 예약에 ")
//                    Text("\(viewModel.rivalCount)명").foregroundStyle(.orange700)
//                    Text(" 도전중")
//                }
//                .setTypo(.caption_12_medium)
//                .foregroundStyle(.gray90)
//            }
//            .padding(.horizontal, 10)
//            .padding(.vertical, 5)
//            .background(.opacityWhite60)
//            .clipShape(Capsule())
        }
    }
    
    private var timerView: some View {
        VStack(spacing: 0) {
            Text(dDay > 0 ? "D-\(dDay)" : "D-DAY")
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray0White)
            Spacer().frame(height: 8)
            HStack(spacing: 4) {
                TimerView(
                    time: viewModel.countDownTimer.hours,
                    description: "시간",
                    backgroundColor: HGColors.opacityPurple4.color
                )
                Text(":")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.opacityWhite60)
                TimerView(
                    time: viewModel.countDownTimer.minutes,
                    description: "분",
                    backgroundColor: HGColors.opacityPurple4.color
                )
                Text(":")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.opacityWhite60)
                TimerView(
                    time: viewModel.countDownTimer.seconds,
                    description: "초",
                    backgroundColor: HGColors.opacityPurple4.color
                )
            }
        }
        .colorScheme(.light)
        .onAppear {
            viewModel.countDownTimer.setupTime(endDate: viewModel.reservation.reservationDatetime ?? Date())
            viewModel.countDownTimer.start()
        }
        .onDisappear {
            viewModel.countDownTimer.stop()
        }
    }
    
    private var readyTipMessage: some View {
        NavigationLink {
            ReadyTipView()
        } label: {
            HStack(spacing: 11) {
                HGImages.readyBell.image
                    .resizable()
                    .frame(40)
                Text("예약 1시간 전부터\n준비 버튼을 누를 수 있어요!")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray95)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                HGIcons.arrowRight.image
                    .foregroundStyle(.gray40)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(.ultraThinMaterial)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(viewModel.category.widthGradient, lineWidth: 1)
            }
            .shadow(color: HGColors.purpleDark.color.opacity(0.15), radius: 20, x: 0, y: 2)
            .colorScheme(.light)
        }
    }
    
    var profileSectionView: some View {
        makeSectionCardView(icon: .person, title: "내 프로필") {
            HStack(spacing: 12) {
                profileImageView(type: viewModel.me.profileType)
                Text(viewModel.me.nickname)
                    .setTypo(.body_16_bold)
                    .foregroundStyle(.gray95)
                Spacer()
                Button {
                    viewModel.reduce(.readyButtonTapped)
                } label: {
                    Text("준비 완료")
                        .setTypo(.body_14_bold)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .background(viewModel.isReady ? .orange500Main : .gray30)
                        .clipShape(Capsule())
                }
                .disabled(!viewModel.isWithinOneHours)
            }
            .overlay(alignment: .topTrailing) {
                if !viewModel.isWithinOneHours {
                    makeReadyTipBubleView
                        .padding(.trailing, 12)
                        .offset(y: -8)
                }
            }
        }
    }
    
    private var makeReadyTipBubleView: some View {
        Text("예약 1시간 전 활성화 돼요")
            .setTypo(.caption_11_medium)
            .foregroundStyle(.gray0White)
            .frame(height: 25)
            .frame(width: 108)
            .background {
                HGToolTipShape(tipXRatio: 0.97)
                    .foregroundStyle(.orange400)
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
                Text("\(viewModel.members.count)명")
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.orange500Main)
                Spacer()
                Button {
                    viewModel.reduce(.refreshButtonTapped)
                } label: {
                    HGIcons.retry.image
                        .resizable()
                        .frame(18)
                }
            }
            
            if !viewModel.members.isEmpty {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 7),
                        GridItem(.flexible(), spacing: 7)
                    ],
                    spacing: 9
                ) {
                    ForEach(viewModel.members, id: \.userId) { member in
                        makeTeamMemberView(member: member)
                    }
                }
            } else {
                VStack(spacing: 8) {
                    HGImages.emptyTeamMember.image
                        .resizable()
                        .frame(width: 192, height: 74)
                    Text("아직 함께하는 팀원이 없어요!\n예약 초대장을 친구에게 보내보세요")
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.gray50)
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 17)
                .fillMaxWidth(.center)
                .background(.gray15)
                .setRadius(20)
            }
            
            HGButton(
                title: "+ 초대장 보내기",
                size: .large,
                variant: .subtle,
                isMaxWidth: true
            ) {
                viewModel.reduce(.inviteButtonTapped)
            }
        }
        .fillMaxWidth()
        .padding(.horizontal, innerPadding)
        .padding(.top, 14)
        .padding(.bottom, 16)
        .background(.gray0White)
        .setRadius(28)
    }
    
    private func makeTeamMemberView(member: ReservationMember) -> some View {
        VStack {
            Spacer()
            ZStack(alignment: .top) {
                ZStack(alignment: .bottom) {
                    HGColors.gray10.color
                        .setRadius(24)
                    HGColors.gray0White.color
                        .setRadius(22)
                        .frame(height: 115)
                        .padding(1)
                }
                .frame(height: 158)
                VStack(spacing: 6) {
                    profileImageView(type: member.profileType)
                    Text(member.nickname)
                        .setTypo(.body_16_bold)
                        .foregroundStyle(.gray95)
                    Button {
                        viewModel.reduce(.kokButtonTapped(member.userId))
                    } label: {
                        Text("콕 찌르기")
                            .setTypo(.body_14_bold)
                            .foregroundStyle(.gray0White)
                            .frame(height: 31)
                            .frame(maxWidth: .infinity)
                            .background(.orange500Main)
                            .clipShape(Capsule())
                    }
                }
                .padding(.top, 15)
                .padding(.horizontal, 11)
            }
        }
        .frame(height: member.status == .ready ? 175 : 158)
        .overlay(alignment: .top) {
            if member.status == .ready {
                makeReadyBubbleView
                    .shadow(
                        color: HGColors.gray100Black.color.opacity(0.07),
                        radius: 4
                    )
            }
        }
    }
    
    private var makeReadyBubbleView: some View {
        Text("준비 완료!")
            .setTypo(.caption_12_bold)
            .foregroundStyle(.orange500Main)
            .frame(height: 28)
            .padding(.horizontal, 15)
            .background {
                HGToolTipShape()
                    .strokeBorder(HGColors.gray15.color, lineWidth: 1)
            }
            .background {
                HGToolTipShape()
                    .foregroundStyle(.gray0White)
            }
    }
    
    private var linkSectionView: some View {
        makeSectionCardView(icon: .link, title: "링크") {
            HStack(spacing: 4) {
                HGIcons.linkURL.image
                    .resizable()
                    .foregroundStyle(.gray70)
                    .frame(24)
                Text(viewModel.reservation.linkUrl)
                    .lineLimit(1)
                    .setTypo(.body_16_bold)
                    .foregroundStyle(.gray80)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .strokeBorder(HGColors.gray20.color, radius: 14)
            .onTapGesture {
                guard let url = URL(string: viewModel.reservation.linkUrl),
                      UIApplication.shared.canOpenURL(url) else {
                    viewModel.reduce(.showInvalidLinkToast)
                    return
                }
                UIApplication.shared.open(url)
            }
        }
    }
    
    private var sharedPhotosSectionView: some View {
        makeSectionCardView(icon: .cameraShare, title: "공유된 사진") {
            HStack(spacing: 5) {
                ForEach(Array(viewModel.reservation.images.enumerated()), id: \.offset) { index, imageURLString in
                    Button {
                        viewModel.reduce(.showImageViewer(index))
                    } label: {
                        LazyImage(url: URL(string: imageURLString)) { state in
                            if let image = state.image {
                                image
                                    .resizable()
                            } else {
                                HGColors.opacityBlack10.color
                            }
                        }
                        .frame(photoGridSize)
                        .setRadius(16)
                        .strokeBorder(HGColors.gray20.color, radius: 16, linewidth: 1)
                    }
                }
            }
        }
    }
    
    private var descriptionSectionView: some View {
        makeSectionCardView(icon: .writePencilCircle, title: "설명") {
            Text(viewModel.reservation.description)
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
    ReservationView(reservationId: 0, category: .activity)
}
