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
    @State private var viewModel: ReservationResultDetailViewModel = .init()
    
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
                .padding(.horizontal, 16)
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
            Color.red
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
    
    private var reservationSuccessDateSectionView: some View {
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
    
    @ViewBuilder
    private var sharedPhotoSectionView: some View {
        makeSectionContainerView(title: "사진") {
            if viewModel.photoImages.isEmpty {
                makeEmptyView(title: "공유된 사진이 없어요")
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 9) {
                        ForEach(viewModel.photoImages.indices, id: \.self) { index in
                            Image(uiImage: viewModel.photoImages[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(106)
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
        .padding([.horizontal, .top], 16)
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
