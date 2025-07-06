//
//  CreateReservationViewModel.swift
//  CreateReservationFeature
//
//  Created by iOS신상우 on 6/28/25.
//

import Foundation
import SwiftUI
import PhotosUI

import HGCommon
import CreateReservationDomain
import ReservationDomain
import HGImageUploader
import HGDesignSystem

@Observable
final class CreateReservationViewModel: Reducerable {
    private weak var coordinator: CreateReservationCoordinator?
    
    init(coordinator: CreateReservationCoordinator?) {
        self.coordinator = coordinator
    }
    
    var state: State = .init()
    
    // Constants
    let bannerContent = "예약 주최자에 한해 생성 이후에도 수정 가능해요."
    let allCategory = ReservationCategoryType.allCases
    
    @ObservationIgnored
    private let event: Debouncer = .init()
    
    @ObservationIgnored
    @Dependency private var createReservationUseCase: CreateReservationUseCase
    
    @ObservationIgnored
    @Dependency var imageUploader: any HGImageUploader
    
    struct State {
        var title: String = ""
        var selectedCategory: ReservationCategoryType?
        var selectedDate: Date?
        var selectedTime: Date?
        var url: String = ""
        var description: String = ""
        var selectedPhotos: [PhotosPickerItem] = []
        
        var showDatePicker: Bool = false
        var showTimePicker: Bool = false
        var isShowDialog: Bool = false
        var isLoading: Bool = false
        
        var isEnabledFinishButton: Bool {
            title.isNotEmpty &&
            selectedDate.isSome &&
            selectedTime.isSome &&
            url.isNotEmpty &&
            selectedCategory.isSome
        }
    }
    
    enum Action {
        case didTapDeletePhoto(PhotosPickerItem)
        case didTapFinish
        case didTapDismiss
        case didSelectCategory(ReservationCategoryType)
        
        case didTapTimePicker
        case didTapDatePicker
        case didSelectDate(Date)
        case didSelectTime(Date)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .didTapDismiss:
            state.isShowDialog = true
        case let .didTapDeletePhoto(item):
            self.state.selectedPhotos.removeAll { $0 == item }
        case let .didSelectCategory(category):
            self.state.selectedCategory = category
        case .didTapFinish:
            Task {
                await self.event.debounce(delay: 1) {
                    await self.createReservation()
                }
            }
        case .didTapDatePicker:
            state.showDatePicker = true
        case .didTapTimePicker:
            state.showTimePicker = true
        case let .didSelectDate(date):
            state.selectedDate = date
        case let .didSelectTime(date):
            state.selectedTime = date
        }
    }
    
    private func createReservation() async {
        do {
            /// URL 검사
            guard validateURLFormat(self.url) else {
                await ToastUtils.showToast("유효한 URL이 아닙니다.")
                return
            }
            
            await MainActor.run {
                self.state.isLoading = true
            }
            
            /// 이미지 업로드
            let imgUrls: [String] = try await withThrowingTaskGroup(of: String.self) { group in
                for photo in state.selectedPhotos {
                    group.addTask { try await self.uploadImage(photo) }
                }
                
                return try await group.reduce(into: [String]()) { $0.append($1) }
            }
            
            /// 예약 생성
            let reservationInfo: CreateReservationRequest = .init(
                title: self.title,
                cateogry: self.selectedCategory?.rawValue ?? "",
                date: self.selectedDate ?? .now,
                time: self.selectedTime ?? .now,
                linkUrl: self.url,
                description: self.description,
                images: imgUrls
            )
            
            let response = try await self.createReservationUseCase.createReservation(
                with: reservationInfo
            )
            
            await MainActor.run {
                state.isLoading = false
                coordinator?.push(.shareReservation(reservationId: response.reservationId))
            }
        } catch let error as HGError {
            await MainActor.run { self.state.isLoading = false }
            
            switch error {
            case .imageConversionFailed,
                    .imageLoadFailed,
                    .imageUploadFailed:
                await ToastUtils.showToast(error.localizedDescription)
            default:
                await ToastUtils.showToast("예약을 생성하지 못했어요")
            }
        } catch {
            await MainActor.run { self.state.isLoading = false }
            await ToastUtils.showToast("예약을 생성하지 못했어요")
        }
    }
    
    private func uploadImage(_ photo: PhotosPickerItem) async throws -> String {
        guard let uiImage = await photo.loadImage() else {
            throw HGError.imageLoadFailed
        }
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.7) else {
            throw HGError.imageConversionFailed
        }
        
        guard let filePath = try? await self.imageUploader.uploadImage(
            type: .info,
            imageData: imageData
        ) else {
            throw HGError.imageUploadFailed
        }
        
        return filePath
    }
    
    // 추후 다른데서 필요하면 도메인으로 뺄게요
    private func validateURLFormat(_ string: String) -> Bool {
        let pattern = #"^(http|https)://[^\s/$.?#].[^\s]*$"#
        return string.range(of: pattern, options: .regularExpression) != nil
    }
}
