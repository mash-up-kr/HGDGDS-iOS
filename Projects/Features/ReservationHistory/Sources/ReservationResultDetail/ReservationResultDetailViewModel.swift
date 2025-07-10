//
//  ReservationResultDetailViewModel.swift
//  ReservationHistoryFeature
//
//  Created by Enes on 7/10/25.
//

import Foundation
import HGCommon
import ReservationDomain
import UserDomain

@Observable
final class ReservationResultDetailViewModel: Reducerable {
    enum Action {
        
    }
    
    struct State {
        var profile: ProfileType
        var reservationTitle: String
        var reservationDateString: String
        var reservationTimeString: String
        var userName: String
        var photoURLs: [String] = []
        var description: String
    }
    
    var state: State
    
    init() {
        self.state = State(
            profile: .green,
            reservationTitle: "테스트타이릍",
            reservationDateString: "0000년 00월 00일",
            reservationTimeString: "오후 0시",
            userName: "나야나" + "(나)",
            photoURLs: [
                "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png",
                "https://mond-al.github.io/assets/images/forTest/ratio/all_ratio/image_8_854x480.png"
            ],
            description: ""
        )
    }
    
    func reduce(_ action: Action) {
        
    }
}
