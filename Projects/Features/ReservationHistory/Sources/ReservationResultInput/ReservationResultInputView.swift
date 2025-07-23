//
//  ReservationResultInputView.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/28/25.
//

import SwiftUI
import HGDesignSystem
import ReservationHistoryDomain
import HGCommon

struct ReservationResultInputView: View {
    @State private var viewModel: ReservationResultInputViewModel
    @FocusState private var isFocused: Bool
    @State private var coordinator: any Coordinatorable
    
    init(coordinator: any Coordinatorable, reservationID: Int, title: String) {
        self.coordinator = coordinator
        self._viewModel = State(
            initialValue: .init(
                reservationID: reservationID,
                title: title
            )
        )
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if viewModel.isShowSectionTitleView {
                    sectionTitle.opacity(viewModel.isShowSectionTitleView ? 1 : 0)
                        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
                }
                Spacer().frame(height: 20)
                HStack(spacing: 2) {
                    resultSelectedButton(type: .success)
                    resultSelectedButton(type: .ambiguousSuccess)
                    resultSelectedButton(type: .fail)
                }
                successInputFormView.opacity(viewModel.isShowSuccessInfoView ? 1 : 0)
            }
            .fillMaxWidth(.center)
            .animation(.bouncy, value: viewModel.selectedReservationResult)
        }
        .applyNavigationBar(
            title: "예약 결과",
            backgroundColor: HGColors.gray0White.color,
            rightButtonView: {
                Button {
                    viewModel.reduce(.didTapDoneButton)
                } label: {
                    Text("완료")
                        .setTypo(.body_16_bold)
                        .foregroundStyle(viewModel.isDisableDoneButton ? .gray30 : .orange500Main)
                }
                .disabled(viewModel.isDisableDoneButton)
            }
        )
        .sheet(isPresented: $viewModel.state.isPresentedDatePicker) {
            DatePicker(
                "",
                selection: .init(
                    get: { viewModel.successReservationDate ?? .now },
                    set: { viewModel.reduce(.didChangeDate($0)) }
                ),
                in: Date.now...,
                displayedComponents: [.date]
            )
            .datePickerStyle(.wheel)
            .presentationDetents([.height(200)])
            .presentationDragIndicator(.visible)
            .frame(width: 200)
        }
        .sheet(isPresented: $viewModel.state.isPresentedHourPicker) {
            DatePicker(
                "",
                selection: .init(
                    get: { viewModel.successReservationTime ?? .now },
                    set: {
                        let selectedDate = viewModel.successReservationDate ?? .now
                        let fullDateTime = selectedDate.addingTimeInterval($0.timeIntervalSinceNow)
                        if fullDateTime > Date.now {
                            viewModel.reduce(.didChangeTime($0))
                        } else {
                            viewModel.reduce(.didChangeTime(.now))
                        }
                    }
                ),
                displayedComponents: [.hourAndMinute]
            )
            .datePickerStyle(.wheel)
            .presentationDetents([.height(200)])
            .presentationDragIndicator(.visible)
            .frame(width: 200)
        }
        .onChange(of: viewModel.isCompleted) { _, isCompleted in
            if isCompleted {
                coordinator.pop()
            }
        }
    }
        
    private var sectionTitle: some View {
        VStack(spacing: 0) {
            Text(viewModel.title)
                .setTypo(.heading_24_bold)
                .foregroundStyle(.orange500Main)
            Spacer().frame(height: 2)
            Text("예약 결과는 어떠셨나요?")
                .setTypo(.heading_24_bold)
                .foregroundStyle(.gray95)
            Spacer().frame(height: 10)
            Text("팀원들에게 예약 결과를 공유해주세요!")
                .setTypo(.body_14_medium)
                .foregroundStyle(.gray40)
        }
        .padding(.top, 32)
        .padding(.bottom, 40)
    }
    
    private func resultSelectedButton(type: ReservationResultType) -> some View {
        ZStack(alignment: .top) {
            VStack(spacing: 2) {
                type.image.resizable()
                    .frame(68)
                Text(type.title)
                    .setTypo(.body_14_bold)
                    .foregroundStyle(.gray90)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 9)
        }
        .frame(100)
        .background(.gray10)
        .setRadius(16)
        .padding(4)
        .strokeBorder(
            viewModel.selectedReservationResult == type ? HGColors.orange500Main.color : .clear,
            radius: 18,
            linewidth: 2
        )
        .animation(.easeInOut, value: viewModel.selectedReservationResult)
        .onTapGesture {
            viewModel.reduce(.didTapResultButton(type))
        }
    }
    
    private var successInputFormView: some View {
        VStack(spacing: 0) {
            HGColors.gray15.color.frame(height: 6)
                .padding(.vertical, 25)
            Text("성공한 예약 정보를 공유해주세요!")
                .setTypo(.title_20_bold)
                .foregroundStyle(.gray95)
            Spacer().frame(height: 28)
            VStack(spacing: 32) {
                successReservationDateInfoView
                registerPhotoView
                explainView
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var successReservationDateInfoView: some View {
        HStack(spacing: 12) {
            HGTextField(
                title: "예약 성공 날짜",
                text: .constant(viewModel.successReservationDateString ?? ""),
                placeholder: "예약 날짜 선택",
                size: .default,
                maxCount: nil,
                hiddenClearButton: true,
                required: true
            )
            .disabled(true)
            .contentShape(.rect)
            .onTapGesture {
                viewModel.reduce(.didTapReservationDateButton)
            }
            
            HGTextField(
                title: "예약 성공 시간",
                text: .constant(viewModel.successReservationTimeString ?? ""),
                placeholder: "예약 시간 선택",
                size: .default,
                maxCount: nil,
                hiddenClearButton: true
            )
            .disabled(true)
            .contentShape(.rect)
            .onTapGesture {
                viewModel.reduce(.didTapReservationHourButton)
            }
        }
    }
    
    private var registerPhotoView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Text("사진")
                    .setTypo(.caption_12_medium)
                    .foregroundStyle(.gray80)
                Text("최대 3장까지 등록 가능해요")
                    .setTypo(.caption_12_medium)
                    .foregroundStyle(.gray50)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    HGPhotoPickerView(
                        selectedItems: $viewModel.state.photoItems,
                        maxSelectCount: 3
                    )
                    ForEach(viewModel.photoItems.indices, id: \.self) { index in
                        HGPhotoBox(
                            item: viewModel.photoItems[index],
                            action: { _ in
                                viewModel.reduce(.didTapRemovePhotoItemIndex(index))
                            }
                        )
                    }
                }
            }
        }
    }

    private var explainView: some View {
        HGLongTextView(
            text: $viewModel.state.explainString,
            isFocused: $isFocused,
            title: "설명",
            placeholder: "성공한 예약과 관련된 정보를 입력해주세요",
            maxCount: 100
        )
    }
}
