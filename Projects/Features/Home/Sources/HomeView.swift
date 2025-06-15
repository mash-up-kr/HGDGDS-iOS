//
//  HomeView.swift
//  Home
//
//  Created by 김남수 on 25/06/14.
//

import SwiftUI

import HGCommon

struct HomeView: View {
    @Environment(HomeCoordinator.self) var coordinator
    
    var body: some View {
        Text("Hello Home 허거덩거덩스")
        Button {
            coordinator.push(.soonReservationDetail)
        } label: {
            Text("온보딩푸시하기")
        }
    }
}

#Preview {
    HomeView()
}
