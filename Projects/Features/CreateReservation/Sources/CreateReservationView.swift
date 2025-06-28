//
//  CreateReservationView.swift
//  CreateReservation
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGDesignSystem

struct CreateReservationView: View {
    @Bindable private var viewModel: CreateReservationViewModel = .init()
    @FocusState private var focus: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                // 편집이 추후 추가되면 다시 나올 배너뷰
//                bannerArea
//                    .padding(.horizontal, 16)
                titleArea
                    .padding([.top, .horizontal], 16)
                categoryArea
                    .padding(.top, 34)
                dateAndTimeArea
                    .padding(.top, 46)
                    .padding(.horizontal, 16)
                urlArea
                    .padding(.top, 48)
                    .padding(.horizontal, 16)
                photoArea
                    .padding(.top, 48)
                    .padding(.horizontal, 16)
                descriptionArea
                    .padding(.top, 36)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 16)
            .padding(.bottom, 56)
        }
        .scrollIndicators(.hidden)
        .applyNavigationBar(title: "예약 일정 생성", leftButtonType: .close, rightButtonView:  {
            barRightButton
        })
        .sheet(isPresented: $viewModel.state.showDatePicker) {
            DatePicker(
                "",
                selection: .init(
                    get: { viewModel.selectedDate ?? .now },
                    set: { viewModel.reduce(.didSelectDate($0)) }
                ),
                displayedComponents: [.date]
            )
            .datePickerStyle(.wheel)
            .presentationDetents([.height(200)])
            .frame(width: 200)
        }
        .sheet(isPresented: $viewModel.state.showTimePicker) {
            VStack(alignment: .center, spacing: .zero) {
                DatePicker(
                    "",
                    selection: .init(
                        get: { viewModel.selectedTime ?? .now },
                        set: { viewModel.reduce(.didSelectTime($0)) }
                    ),
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .presentationDetents([.height(200)])
                .frame(width: 200)
            }
        }
    }
    
    // MARK: - navigationRightButton
    
    private var barRightButton: some View {
        Button {
            viewModel.reduce(.didTapFinish)
        } label: {
            Text("완료")
                .setTypo(.body_16_bold)
                .foregroundStyle(viewModel.isEnabledFinishButton ? .orange500Main : .gray30)
        }
    }
    
    // MARK: - BannerArea
    
    private var bannerArea: some View {
        HStack(spacing: 4) {
            HGIcons.information.image
                .resizable()
                .frame(16)
                .foregroundStyle(.gray40)
            Text(viewModel.bannerContent)
                .setTypo(.body_14_medium)
                .foregroundStyle(.gray50)
        }
        .fillMaxWidth()
        .padding(12)
        .background(.gray10)
        .setRadius(12)
    }
    
    // MARK: - TitleArea
    
    private var titleArea: some View {
        HGTextField(
            title: "제목",
            text: $viewModel.state.title,
            placeholder: "제목을 입력해주세요",
            required: true
        )
    }
    
    // MARK: - CategoryArea
    
    private var categoryArea: some View {
        VStack(spacing: .zero) {
            SectionHeader(
                title: "카테고리",
                isRequired: true,
                content: "카테고리 이미지가 배경에 반영돼요"
            )
            .padding(.bottom, 12)
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(viewModel.allCategory, id: \.self) { category in
                        Button {
                            viewModel.reduce(.didSelectCategory(category))
                        } label: {
                            VStack(spacing: 2) {
                                HGColors.gray50.color.frame(68)
                                Text(category.title)
                                    .setTypo(.body_14_bold)
                                    .foregroundStyle(.gray90)
                            }
                            .frame(100)
                            .background(.gray10)
                            .setRadius(16)
                            .padding(2)
                            .if(viewModel.selectedCategory == category) {
                                $0.strokeOutterBorder(
                                    HGColors.orange500Main.color,
                                    radius: 16,
                                    linewidth: 2
                                )
                            }
                            .padding(2)
                        }
                    }
                }
            }
            .contentMargins(.horizontal, 16)
        }
    }
    
    // MARK: - DateAndTimeArea
    
    private var dateAndTimeArea: some View {
        HStack(spacing: 12) {
            HGTextField(
                title: "예약 날짜",
                text: .init(
                    get: { viewModel.state.selectedDate?.formatted(with: .yyyyMMddEEKorean) ?? "" },
                    set: { _ in }
                ),
                placeholder: "예약 날짜 선택",
                required: true
            )
            .disabled(true)
            .onTapGesture {
                viewModel.reduce(.didTapDatePicker)
            }
            
            HGTextField(
                title: "예약 시간",
                text: .init(
                    get: { viewModel.state.selectedTime?.formatted(with: .ahhmmKorean) ?? "" },
                    set: { _ in }
                ),
                placeholder: "예약 시간 선택",
                required: true
            )
            .disabled(true)
            .onTapGesture {
                viewModel.reduce(.didTapTimePicker)
            }
        }
    }
    
    // MARK: - UrlArea
    
    private var urlArea: some View {
        VStack(alignment: .leading, spacing: 12) {
            HGTextField(
                title: "URL",
                text: $viewModel.state.url,
                placeholder: "예약이 진행되는 링크를 첨부해주세요",
                required: true
            )

            Button {
                viewModel.reduce(.toggleLinkTitleEnabled)
            } label: {
                HStack(spacing: .zero) {
                    let icon = viewModel.isLinkTitleEnabled ? HGIcons.checkOnInBox : HGIcons.checkOffInBox
                    
                    icon.image
                        .resizable()
                        .frame(20)
                    Text("맞춤 제목 설정")
                        .setTypo(.body_14_medium)
                        .foregroundStyle(.gray80)
                        .padding(.leading, 4)
                    
                    if viewModel.isLinkTitleEnabled {
                        HGTextField(
                            text: $viewModel.state.linkTitle,
                            placeholder: "링크 제목 입력"
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .frame(height: 30)
        }
        .animation(.spring, value: viewModel.isLinkTitleEnabled)
    }
    
    // MARK: - PhotoArea
    
    private var photoArea: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(
                title: "사진",
                isRequired: false,
                content: "최대 3장까지 등록 가능해요"
            )
            .padding(.bottom, 12)
            
            HStack(spacing: 12) {
                HGPhotoPickerView(
                    selectedItems: $viewModel.state.selectedPhotos,
                    maxSelectCount: 3
                )
                
                ForEach(viewModel.selectedPhotos.indices, id: \.self) { i in
                    let image = viewModel.selectedPhotos[i]
                    
                    HGPhotoBox(item: image) { item in
                        viewModel.reduce(.didTapDeletePhoto(item))
                    }
                }
            }
        }
        .animation(.spring, value: viewModel.selectedPhotos)
    }
    
    // MARK: - DescriptionArea
    
    private var descriptionArea: some View {
        HGLongTextView(
            text: $viewModel.state.description,
            isFocused: $focus,
            title: "설명",
            placeholder: "예약에 관한 설명을 자유롭게 작성해주세요",
            maxCount: 100
        )
    }
}

#Preview(traits: .applyFont) {
    CreateReservationView()
}
