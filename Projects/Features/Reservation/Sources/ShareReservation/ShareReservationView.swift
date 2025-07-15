//
//  ShareReservationView.swift
//  ReservationFeature
//
//  Created by iOS신상우 on 7/4/25.
//

import SwiftUI

import HGDesignSystem
import HGCommon
import NukeUI
import ReservationFeatureInterface

struct ShareReservationView: View {
    @Bindable var viewModel: ShareReservationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: .zero) {
            if viewModel.reservation == nil {
                HGColors.gray0White.color
                    .onAppear {
                        viewModel.reduce(.fetchReservationInfo)
                    }
            } else {
                topArea
                Spacer().frame(maxHeight: 79)
                cardView.padding(.horizontal, 32)
                Spacer()
                bottomArea
            }
        }
        .applyNavigationBar(
            title: "",
            leftButtonType: .none,
            rightButtonView:  {
                Button {
                    viewModel.reduce(.didTapDismiss(dismiss: { dismiss() }))
                } label: {
                    HGIcons.close.image
                        .foregroundStyle(.gray0White)
                }
            }
        )
        .background{
            if let reservation = viewModel.reservation {
                reservation.category.background.image
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                HGColors.gray0White.color
            }
        }
        .background {
            if let url = DeepLinkPath.invite.generateDeeplinkURL(
                parameters: ["reservationId":"\(viewModel.reservationId)"]
            ) {
                ActivityView(
                    isPresented: $viewModel.state.isPresentedShareSheet,
                    items: [url]
                )
            } else {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: $viewModel.state.isPresentedImageViewer, content: {
            ImageSwipeView(showIndex: viewModel.selectedImageIndex, images: viewModel.uiImages)
        })
        .isLoading(viewModel.isLoading, opacity: 0.01)
    }
    
    private var cardView: some View {
        VStack {
            Text("이미지를 탭 해보세요")
                .setTypo(.body_14_bold)
                .padding(.vertical, 6)
                .foregroundStyle(.gray70)
                .background {
                    HGToolTipShape(tipXRatio: 0.5)
                        .fill(HGColors.gray0White.color)
                }
                .padding(.bottom, 12)
            
            ZStack {
                switch viewModel.state.cardState {
                case .front:
                    cardFrontView
                        .compositingGroup()
                        .transition(.flip)
                        .applySwayRepeatAnimation()
                case .back:
                    cardBackView
                        .transition(.reverseFlip)
                }
            }
            .onTapGesture {
                withAnimation(.bouncy(duration: 0.5)) {
                    viewModel.reduce(.toggleCardState)
                }
            }
            .sensoryFeedback(
                .impact(weight: .light),
                trigger: viewModel.cardState == .back
            )
        }
    }
    
    private var cardFrontView: some View {
        VStack(spacing: .zero) {
            HStack(spacing: 4) {
                if let hostProfile = viewModel.hostProfile {
                    hostProfile.image
                        .resizable()
                        .scaledToFit()
                        .frame(24)
                        .clipShape(.circle)
                } else {
                    HGColors.opacityBlack10.color
                        .frame(24)
                        .clipShape(.circle)
                }
                
                Text(viewModel.reservation?.host.nickName ?? "호스트")
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.white)
                Text("님이 생성")
                    .setTypo(.body_14_regular)
                    .foregroundStyle(.white.opacity(0.6))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .background(.ultraThinMaterial)
            .setRadius(30)
            .environment(\.colorScheme, .light)
            
            Spacer()
            
            if let reservation = viewModel.reservation {
                HGTagView(
                    style: .medium,
                    title: reservation.category.title,
                    textColor: reservation.category.tagTextColor,
                    backgroundColor: reservation.category.tagBackgroundColor
                )
                .padding(.bottom, 5)
            }
            
            Text(viewModel.reservation?.title ?? "")
                .setTypo(.display_32_extraBold)
                .foregroundStyle(.gray95)
                .padding(.bottom, 1)
                .fillMaxWidth(.center)
            HStack(spacing: .zero) {
                HGIcons.calendar.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.gray50)
                    .padding(.trailing, 2)
                Text(viewModel.reservation?.reservationDatetime?.formatted(with: .yyyyMMddKorean) ?? "-")
                    .foregroundStyle(.gray70)
                    .padding(.trailing, 4)
                
                HGIcons.timer.image
                    .resizable()
                    .frame(16)
                    .foregroundStyle(.gray50)
                    .padding(.trailing, 2)
                Text(viewModel.reservation?.reservationDatetime?.formatted(with: .ahhmmKorean) ?? "-")
                    .foregroundStyle(.gray70)
            }
            .setTypo(.body_14_medium)
        }
        .padding(.horizontal, 22)
        .padding(.top, 26)
        .padding(.bottom, 29)
        .frame(height: 402)
        .background {
            if let image = viewModel.reservation?.category.card.image {
                image
                    .resizable()
                    .scaledToFill()
            } else {
                HGColors.gray15.color
            }
        }
        .setRadius(31)
        .strokeOutterBorder(
            HGGradient.strokeGradient.opacity(0.6),
            radius: 31,
            linewidth: 3
        )
        .compositingGroup()
    }
    
    private var cardBackView: some View {
        VStack(spacing: .zero) {
            Text("상세 정보")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
                .fillMaxWidth()
            Spacer()
            cardDetailHeader(
                icon: .link,
                title: "링크",
                content: viewModel.reservation?.linkUrl ?? "-"
            ) {
                guard let url = URL(string: viewModel.reservation?.linkUrl ?? ""),
                      UIApplication.shared.canOpenURL(url) else {
                    viewModel.reduce(.showInvalidLinkToast)
                    return
                }
                UIApplication.shared.open(url)
            }
            HGDividerView().padding(.vertical, 12)
            cardDetailHeader(
                icon: .camera,
                title: "공유 사진",
                content: nil,
                boldContent: "\(viewModel.reservation?.images.count ?? 0)장"
            )
            .padding(.bottom, 10)
            
            if let images = viewModel.reservation?.images, images.isNotEmpty {
                HStack(spacing: .zero) {
                    ForEach(viewModel.uiImages.indices, id: \.self) { i in
                        let uiImage = viewModel.uiImages[i]
                        Button {
                            viewModel.reduce(.didTapImage(i))
                        } label: {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(87)
                                .strokeBorder(
                                    HGColors.gray20.color,
                                    radius: 15,
                                    linewidth: 1
                                )
                        }
                        Spacer()
                    }
                }
            } else {
                Text("공유된 사진이 없어요")
                    .setTypo(.caption_12_regular)
                    .foregroundStyle(.gray50)
                    .fillMaxWidth(.center)
                    .frame(height: 87)
                    .background(.gray10)
                    .setRadius(10)
                
            }
            HGDividerView().padding(.vertical, 12)
            cardDetailHeader(
                icon: .writePencilCircle,
                title: "설명",
                content: nil
            )
            .padding(.bottom, 4)
            if let description = viewModel.reservation?.description, description.isNotEmpty {
                Text(description)
                    .setTypo(.body_14_regular)
                    .fillMaxWidth()
                    .foregroundStyle(.gray80)
                    .multilineTextAlignment(.leading)
                    .lineLimit(4)
                
            } else {
                Text("작성된 내용이 없어요")
                    .setTypo(.caption_12_regular)
                    .foregroundStyle(.gray50)
                    .fillMaxWidth(.center)
                    .padding(.vertical, 12)
                    .background(.gray10)
                    .setRadius(10)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 26)
        .padding(.bottom, 22)
        .fillMaxWidth()
        .frame(height: 402)
        .background(.gray0White)
        .setRadius(31)
        .strokeOutterBorder(
            HGGradient.strokeGradient.opacity(0.6),
            radius: 31,
            linewidth: 3
        )
    }
    
    private var topArea: some View {
        Text(viewModel.shareViewType.title).padding(.top, 17)
            .setTypo(.heading_24_bold)
            .foregroundStyle(.gray0White)
    }
    
    private var bottomArea: some View {
        HGButton(
            title: viewModel.bottomButtonTitle,
            size: .xLarge,
            isMaxWidth: true
        ) {
            viewModel.reduce(.didTapBottomButton)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 10)
    }
    
    private func cardDetailHeader(
        icon: HGIcons,
        title: String,
        content: String?,
        onTapContent: (()->Void)? = nil,
        boldContent: String? = nil
    ) -> some View {
        HStack(spacing: 2) {
            icon.image
                .resizable()
                .frame(16)
                .foregroundStyle(.gray50)
            Text(title)
                .setTypo(.body_14_medium)
                .foregroundStyle(.gray80)
            Spacer()
            if let content {
                Text(content)
                    .setTypo(.body_14_regular)
                    .foregroundStyle(.gray95)
                    .lineLimit(1)
                    .frame(maxWidth: 150, alignment: .trailing)
                    .onTapGesture {
                        onTapContent?()
                    }
            }
            
            if let boldContent {
                Text(boldContent)
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray95)
                    .frame(alignment: .trailing)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    private func imageBox(_ imageUrl: String) -> some View {
        LazyImage(url: .init(string: imageUrl)) { state in
            if let image = state.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(87)
                    .strokeBorder(
                        HGColors.gray20.color,
                        radius: 15,
                        linewidth: 1
                    )
            } else {
                HGColors.opacityBlack10.color
                    .frame(87)
                    .setRadius(15)
            }
        }
    }
}

#Preview(traits: .applyFont) {
    ShareReservationView(
        viewModel: .init(
            reservationId: 1,
            shareViewType: .sender,
            coordinator: nil
        )
    )
    .preferredColorScheme(.light)
}
