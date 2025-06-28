//
//  ReservationResultInputViewModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/29/25.
//

import SwiftUI
import HGCommon
import PhotosUI

@Observable
final class ReservationResultInputViewModel: Reducerable {
    enum Action {
        case didTapResultButton(ReservationResultType)
        case didTapReservationDateButton
        case didTapReservationHourButton
        case didChangeDate(Date)
        case didChangeTime(Date)
        case updateDisableDoneButton(Bool)
        case didTapRemovePhotoItemIndex(Int)
        case didTapDoneButton
    }
    
    struct State {
        var selectedReservationResult: ReservationResultType?
        var successReservationDate: Date?
        var successReservationTime: Date?
        var successReservationDateString: String?
        var successReservationTimeString: String?
        var isPresentedDatePicker: Bool = false
        var isPresentedHourPicker: Bool = false
        
        var photoItems: [PhotosPickerItem] = []
        var explainString: String = ""
        
        var isShowSectionTitleView: Bool = true
        var isShowSuccessInfoView: Bool = false
        
        var isDisableDoneButton: Bool = true
    }
    
    var state: State = .init()
    
    func reduce(_ action: Action) {
        switch action {
        case let .didTapResultButton(type):
            state.selectedReservationResult = type
            state.isShowSuccessInfoView = type == .success || type == .ambiguousSuccess
            state.isShowSectionTitleView = type == .fail
        case .didTapReservationDateButton:
            state.isPresentedDatePicker = true
        case .didTapReservationHourButton:
            state.isPresentedHourPicker = true
        case let .didChangeDate(date):
            state.successReservationDate = date
            state.successReservationDateString = date.formatted(with: .yyyyMMddEEKorean)
            validationDoneButton()
        case let .didChangeTime(time):
            state.successReservationTime = time
            state.successReservationTimeString = time.formatted(with: .ahhmmKorean)
        case let .updateDisableDoneButton(isDisable):
            state.isDisableDoneButton = isDisable
        case let .didTapRemovePhotoItemIndex(index):
            removePhotoItemIndex(index)
        case .didTapDoneButton:
            done()
        }
    }
    
    private func validationDoneButton() {
        let isDisable = state.successReservationDate.isNil
        reduce(.updateDisableDoneButton(isDisable))
    }
    
    private func removePhotoItemIndex(_ index: Int) {
        state.photoItems.remove(at: index)
    }
    
    private func done() {
        
    }
}
