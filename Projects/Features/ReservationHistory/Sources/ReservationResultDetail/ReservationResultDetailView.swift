//
//  ReservationResultDetailView.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/1/25.
//

import SwiftUI
import HGDesignSystem
import NukeUI
import HGCommon

struct ReservationResultDetailView: View {
    @State private var viewModel: ReservationResultDetailViewModel
    
    private let innerPadding: CGFloat = 16
    private let outsidePadding: CGFloat = 16
    private let photoSpacing: CGFloat = 9
    private var photoGridSize: CGFloat {
        let padding: CGFloat = outsidePadding + innerPadding
        let spacing: CGFloat = photoSpacing
        return ((UIWindow.current?.screen.bounds.width ?? 300) - (padding + spacing) * 2) / 3
    }
    
    init(state: ReservationResultDetailViewModel.State) {
        self._viewModel = State(initialValue: .init(state: state))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HGColors.gray10.color.frame(height: 1)
            profileHeaderView
            
            ScrollView {
                VStack(spacing: 12) {
                    reservationSuccessDateSectionView
                    sharedPhotoSectionView
                    descriptionSectionView
                }
                .padding(.horizontal, outsidePadding)
            }
            .background(.gray10)
            .contentMargins(.top, 20)
        }
        .applyNavigationBar(title: "예약 결과 상세")
        .onAppear {
            viewModel.reduce(.onAppear)
        }
        .fullScreenCover(isPresented: $viewModel.state.isPresentedPhotoDetail) {
            if let selectedPhotoIndex = viewModel.selectedPhotoIndex {
                ImageSwipeView(
                    showIndex: selectedPhotoIndex,
                    images: viewModel.photoImages
                )
            }
        }
    }
    
    private var profileHeaderView: some View {
        HStack(spacing: 15) {
            viewModel.profile.image
                .resizable()
                .frame(62)
                .setRadius(24)
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.reservationTitle)
                    .setTypo(.caption_12_bold)
                    .foregroundStyle(.orange500Main)
                Text(viewModel.userName)
                    .setTypo(.subTitle_18_bold)
                    .foregroundStyle(.gray95)
            }
        }
        .fillMaxWidth()
        .padding(.horizontal, 16)
        .frame(height: 102)
    }
    
    @ViewBuilder
    private var reservationSuccessDateSectionView: some View {
        if viewModel.reservationDateString.isNotEmpty {
            makeSectionContainerView(title: "예약 성공 일자") {
                HStack(spacing: 16) {
                    HStack(spacing: 2) {
                        HGIcons.calendar.image
                            .resizable()
                            .frame(20)
                            .foregroundStyle(.gray50)
                        Text(viewModel.reservationDateString)
                            .setTypo(.body_16_medium)
                            .foregroundStyle(.gray95)
                    }
                    HStack(spacing: 2) {
                        HGIcons.timer.image
                            .resizable()
                            .frame(20)
                            .foregroundStyle(.gray50)
                        Text(viewModel.reservationTimeString)
                            .setTypo(.body_16_medium)
                            .foregroundStyle(.gray95)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var sharedPhotoSectionView: some View {
        makeSectionContainerView(title: "사진") {
            if viewModel.photoImages.isEmpty {
                makeEmptyView(title: "공유된 사진이 없어요")
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: photoSpacing) {
                        ForEach(viewModel.photoImages.indices, id: \.self) { index in
                            Image(uiImage: viewModel.photoImages[index])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(photoGridSize)
                                .strokeBorder(HGColors.opacityBlack10.color, radius: 15, linewidth: 0.75)
                                .onTapGesture {
                                    viewModel.reduce(.didTapPhoto(index: index))
                                }
                        }
                    }
                }
                .scrollIndicators(.never)
            }
        }
    }
    
    @ViewBuilder
    private var descriptionSectionView: some View {
        makeSectionContainerView(title: "설명") {
            if viewModel.description.isEmpty {
                makeEmptyView(title: "공유된 설명이 없어요")
            } else {
                Text(viewModel.description)
                    .setTypo(.body_16_medium)
                    .foregroundStyle(.gray95)
            }
        }
    }
    
    private func makeSectionContainerView(
        title: String,
        @ViewBuilder childView: () -> some View
    ) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .setTypo(.subTitle_18_bold)
                .foregroundStyle(.gray95)
            childView()
        }
        .fillMaxWidth()
        .padding([.horizontal, .top], innerPadding)
        .padding(.bottom, 22)
        .background(.gray0White)
        .setRadius(28)
    }
    
    private func makeEmptyView(title: String) -> some View {
        VStack(spacing: 16) {
            HGImages.noCompleteReservation.image.frame(120)
            Text(title)
                .setTypo(.body_16_bold)
                .foregroundStyle(.gray30)
        }
        .fillMaxWidth(.center)
    }
}
