//
//  ReservationResultInputViewModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/29/25.
//

import UIKit
import HGCommon

@Observable
final class ReservationResultInputViewModel: Reducerable {
    enum Action {
        case didTapResultButton(ReservationResultType)
        case didTapReservationDateButton
        case didTapReservationHourButton
        case didChangeDate(Date)
        case didChangeTime(Date)
        case didChangeImage([UIImage])
        case updateDisableDoneButton(Bool)
    }
    
    struct State {
        var selectedReservationResult: ReservationResultType?
        var successReservationDate: Date?
        var successReservationTime: Date?
        var successReservationDateString: String?
        var successReservationTimeString: String?
        var isPresentedDatePicker: Bool = false
        var isPresentedHourPicker: Bool = false
        
        var images: [UIImage] = []
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
            state.successReservationDateString = "0000.00.00"
            validationDoneButton()
        case let .didChangeTime(time):
            state.successReservationTime = time
            state.successReservationTimeString = "0000.00.00"
        case let .didChangeImage(images):
            state.images = images
        case let .updateDisableDoneButton(isDisable):
            state.isDisableDoneButton = isDisable
        }
    }
    
    private func validationDoneButton() {
        let isDisable = state.successReservationDate.isNil
        reduce(.updateDisableDoneButton(isDisable))
    }
}
