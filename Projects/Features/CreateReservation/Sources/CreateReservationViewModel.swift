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

@Observable
final class CreateReservationViewModel: Reducerable {
    
    var state: State = .init()
    
    // Constants
    let bannerContent = "예약 주최자에 한해 생성 이후에도 수정 가능해요."
    let allCategory = ReservationCategoryType.allCases
    
    @ObservationIgnored
    private let event: Debouncer = .init()
    
    @ObservationIgnored
    @Dependency private var createReservationUseCase: CreateReservationUseCase
    
    struct State {
        var title: String = ""
        var selectedCategory: ReservationCategoryType?
        var selectedDate: Date?
        var selectedTime: Date?
        var url: String = ""
        var linkTitle: String = ""
        var description: String = ""
        var selectedPhotos: [PhotosPickerItem] = []
        var isLinkTitleEnabled: Bool = false
        
        var showDatePicker: Bool = false
        var showTimePicker: Bool = false
        
        var isEnabledFinishButton: Bool {
            title.isNotEmpty &&
            selectedDate.isSome &&
            selectedTime.isSome &&
            url.isNotEmpty &&
            selectedCategory.isSome
        }
    }
    
    enum Action {
        case toggleLinkTitleEnabled
        case didTapDeletePhoto(PhotosPickerItem)
        case didTapFinish
        case didSelectCategory(ReservationCategoryType)
        
        case didTapTimePicker
        case didTapDatePicker
        case didSelectDate(Date)
        case didSelectTime(Date)
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .toggleLinkTitleEnabled:
            self.state.isLinkTitleEnabled = !self.state.isLinkTitleEnabled
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
            let reservationInfo: CreateReservationRequest = .init(
                title: self.title,
                cateogry: self.selectedCategory?.rawValue ?? "",
                date: self.selectedDate ?? .now,
                time: self.selectedTime ?? .now,
                linkUrl: self.url,
                linkTitle: self.linkTitle,
                description: self.description,
                images: [] // TODO: presignedUrlList
            )
            try await self.createReservationUseCase.createReservation(with: reservationInfo)
            
            await MainActor.run {
                NotificationCenter.default.post(name: .createReservationComplete, object: nil)
            }
            
        } catch {
            print("실패")
        }
    }
}
