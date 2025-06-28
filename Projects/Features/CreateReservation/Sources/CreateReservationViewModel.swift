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
        
        var isEnabledFinishButton: Bool { true } // TODO: 임시처리
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
            // TODO: API Call
            break
            
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
}
