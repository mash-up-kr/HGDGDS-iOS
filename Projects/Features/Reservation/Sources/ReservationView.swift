//
//  ReservationView.swift
//  Reservation
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGCommon
import ReservationDomain
import HGDesignSystem

struct ReservationView: View {
    private let innerPadding: CGFloat = 16
    private let outsidePadding: CGFloat = 16
    private var photoGridSize: CGFloat {
        let padding: CGFloat = outsidePadding + innerPadding
        let spacing: CGFloat = 8
        return ((UIWindow.current?.screen.bounds.width ?? 100) - (padding + spacing) * 2) / 3
    }
    @State private var isHiddenNavigationBar = true
    
    @Bindable var viewModel: ReservationViewModel = .init()
    @State private var countDownTimer: CountDownTimerManager = .init()
    
    var dDay: Int { viewModel.reservation.reservationDatetime.dDayValue() }
    
    var body: some View {
        ZStack(alignment: .top) {
            background
            contentView
                .applyNavigationBar(
                    title: isHiddenNavigationBar ? "" : "예약 상세",
                    isHiddenBackground: isHiddenNavigationBar,
                    backgroundColor: .ultraThinMaterial,
                    leftButtonType: .whiteBack,
                    rightButtonView: { navigationRightButton }
                )
                .colorScheme(.dark)
        }
        .dialog(
            isPresented: $viewModel.state.isShowEditPermissionDialog,
            title: "예약을 만든 주최자만\n편집 가능해요",
            description: "주최자에게 편집을 요청하세요",
            image: .categorySuccess,
            okTitle: "확인"
        )
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                titleView
                    .onScrollVisibilityChange(threshold: 0.7) { isHiddenNavigationBar in
                        self.isHiddenNavigationBar = isHiddenNavigationBar
                    }
                Spacer().frame(height: 49)
                timerView
                Spacer().frame(height: 91)
                LazyVStack(spacing: 8) {
                    if !viewModel.isWithin24Hours {
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
        }
        .contentMargins(.bottom, 88)
    }
    
    private var navigationRightButton: some View {
        Button {
            if !viewModel.me.isHost {
                viewModel.reduce(.showEditPermissionDialog(true))
            } else {
                //TODO: 에약 수정 화면 이동
            }
        } label: {
            HGIcons.edit.image
                .resizable()
                .frame(24)
                .foregroundStyle(.gray0White)
        }
    }
    
    private var background: some View {
        VStack(spacing: 0) {
            viewModel.reservation.category.gradient.frame(height: 637)
            HGColors.gray10.color
        }
        .ignoresSafeArea()
    }
    
    private func profileImageView() -> some View {
        Color.red.frame(62)
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
                title: viewModel.reservation.category.title,
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
                Text(viewModel.reservation.reservationDatetime.formatted(with: .yyyyMMddKorean))
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.opacityWhite60)
                HGIcons.timer.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.opacityWhite30)
                Text(viewModel.reservation.reservationDatetime.formatted(with: .ahhmm))
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.opacityWhite60)
            }
            Spacer().frame(height: 8)
            HStack(spacing: 0) {
                HGIcons.fire.image
                    .resizable()
                    .frame(18)
                
                Group {
                    Text("같은 예약에 ")
                    Text("\(viewModel.rivalCount)명").foregroundStyle(.orange700)
                    Text(" 도전중")
                }
                .setTypo(.caption_12_medium)
                .foregroundStyle(.gray90)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.opacityWhite60)
            .clipShape(Capsule())
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
                    time: countDownTimer.hours,
                    description: "시간",
                    backgroundColor: HGColors.opacityPurple4.color
                )
                Text(":")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.opacityWhite60)
                TimerView(
                    time: countDownTimer.minutes,
                    description: "분",
                    backgroundColor: HGColors.opacityPurple4.color
                )
                Text(":")
                    .setTypo(.display_32_extraBold)
                    .foregroundStyle(.opacityWhite60)
                TimerView(
                    time: countDownTimer.seconds,
                    description: "초",
                    backgroundColor: HGColors.opacityPurple4.color
                )
            }
        }
        .colorScheme(.light)
        .onAppear {
            countDownTimer.setupTime(endDate: viewModel.reservation.reservationDatetime)
            countDownTimer.start()
        }
        .onDisappear {
            countDownTimer.stop()
        }
    }
    
    private var readyTipMessage: some View {
        HStack(spacing: 11) {
            HGImages.readyBell.image
                .resizable()
                .frame(40)
            Text("에약 1시간 전부터\n준비 버튼을 누를 수 있어요!")
                .setTypo(.body_14_bold)
                .foregroundStyle(.gray95)
                .frame(maxWidth: .infinity, alignment: .leading)
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
                .stroke(viewModel.reservation.category.widthGradient, lineWidth: 1)
        }
        .shadow(color: HGColors.purpleDark.color.opacity(0.15), radius: 20, x: 0, y: 2)
        .colorScheme(.light)
    }
    
    var profileSectionView: some View {
        makeSectionCardView(icon: .person, title: "내 프로필") {
            HStack(spacing: 12) {
                profileImageView()
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
                        .disabled(!viewModel.isWithin24Hours)
                }
            }
            .overlay(alignment: .topTrailing) {
                if !viewModel.isWithin24Hours {
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
                    profileImageView()
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
            Button {
                viewModel.reduce(.linkButtonTapped)
            } label: {
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
                .strokeBorder(HGColors.gray20.color, radius: 14)
            }
        }
    }
    
    private var sharedPhotosSectionView: some View {
        makeSectionCardView(icon: .cameraShare, title: "공유된 사진") {
            HStack(spacing: 5) {
                ForEach(Array(viewModel.reservation.images.enumerated()), id: \.offset) { index, image in
                    Button {
                        viewModel.reduce(.showImageViewer(index))
                    } label: {
                        Color.red
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
    ReservationView()
}
