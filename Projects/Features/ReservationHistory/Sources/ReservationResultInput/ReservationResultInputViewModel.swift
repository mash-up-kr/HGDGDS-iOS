//
//  ReservationResultInputViewModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 6/29/25.
//

import SwiftUI
import HGCommon
import PhotosUI
import ReservationHistoryDomain
import HGImageUploader
import HGDesignSystem

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
        var isLoading: Bool = false
        var isCompleted: Bool = false
    }
    
    var state: State = .init()
    
    private let reservationID: Int
    
    init(reservationID: Int) {
        self.reservationID = reservationID
    }
    
    @ObservationIgnored
    @Dependency private var imageUploader: HGImageUploader
    @ObservationIgnored
    @Dependency private var reservationHistoryUseCase: any ReservationHistoryUseCase
    
    func reduce(_ action: Action) {
        switch action {
        case let .didTapResultButton(type):
            state.selectedReservationResult = type
            state.isShowSuccessInfoView = type == .success || type == .ambiguousSuccess
            state.isShowSectionTitleView = type == .fail
            checkValidationDoneButton()
        case .didTapReservationDateButton:
            state.isPresentedDatePicker = true
        case .didTapReservationHourButton:
            state.isPresentedHourPicker = true
        case let .didChangeDate(date):
            state.successReservationDate = date
            state.successReservationDateString = date.formatted(with: .yyyyMMddEEKorean)
            checkValidationDoneButton()
        case let .didChangeTime(time):
            state.successReservationTime = time
            state.successReservationTimeString = time.formatted(with: .ahhmmKorean)
        case let .updateDisableDoneButton(isDisable):
            state.isDisableDoneButton = isDisable
        case let .didTapRemovePhotoItemIndex(index):
            removePhotoItemIndex(index)
        case .didTapDoneButton:
            Task {
                await done()
            }
        }
    }
    
    private func checkValidationDoneButton() {
        if state.selectedReservationResult == .fail {
            reduce(.updateDisableDoneButton(false))
        } else {
            reduce(.updateDisableDoneButton(state.successReservationDate.isNil))
        }
    }
    
    private func removePhotoItemIndex(_ index: Int) {
        state.photoItems.remove(at: index)
    }
    
    private func done() async {
        guard !state.isLoading else { return }
        guard let resultType = state.selectedReservationResult else {
            return
        }
        state.isLoading = true
        
        let successReservationDate = state.successReservationDate
        let successDateTime = successReservationDate?.combineWith(time: state.successReservationTime)
        let description: String = state.explainString

        do {
            let imageData = try await encode(photoItems: state.photoItems)
            let paths: [String] = try await withThrowingTaskGroup(of: String.self) { group in
                for datum in imageData {
                    group.addTask { [weak self] in
                        guard let self else {
                            throw HGError.domainError("self nil")
                        }
                        let path = try await self.uploadImage(data: datum)
                        return path
                    }
                }
                var tempPaths: [String] = []
                for try await value in group {
                    tempPaths.append(value)
                }
                return tempPaths
            }
            
            let isSuccess = try await reservationHistoryUseCase.requestRegisterReservationResult(
                reservationId: reservationID,
                resultType: resultType,
                imagePaths: paths,
                successDateTime: successDateTime,
                description: description
            )
            state.isCompleted = isSuccess
        } catch {
            print(error)
        }
        state.isLoading = false
    }
    
    private func encode(photoItems: [PhotosPickerItem]) async throws -> [Data] {
        var imageData: [Data] = []
        for item in state.photoItems {
            guard let image = await item.loadImage(),
                  let datum = image.jpegData(compressionQuality: 0.7) else {
                throw HGError.imageConversionFailed
            }
            imageData.append(datum)
        }
        return imageData
    }
    
    private func uploadImage(data: Data) async throws -> String {
        try await imageUploader.uploadImage(type: .result, imageData: data)
    }
}
