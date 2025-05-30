//
//  RouterTestView.swift
//  HGDGDS-iOS
//
//  Created by Enes on 5/30/25.
//

import SwiftUI

struct RouterTestView: View {
    @Environment(RootCoordinator.self) var coordinator
    
    public var body: some View {
        Text("RootView")
            .padding()
        Button {
            coordinator.presentChatView()
        } label: {
            Text("ChatView")
        }
        Button {
            coordinator.presentBookView()
        } label: {
            Text("BookingView")
        }
        Button {
            coordinator.moveTo(.nested)
        } label: {
            Text("RootView")
        }
        Button {
            coordinator.popToRoot()
        } label: {
            Text("전부제거")
        }
    }
}

#Preview {
    RouterTestView()
}
