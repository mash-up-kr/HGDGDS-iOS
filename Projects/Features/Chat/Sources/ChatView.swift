//
//  ChatView.swift
//  Chat
//
//  Created by  on .
//

import SwiftUI
import ChatDomain
import HGDesignSystem

struct ChatView: View {
    @Environment(ChatCoordinator.self) var coordinator
    @Environment(\.dismiss) var dismiss
    
    init() {
        print(#function, #file)
    }
    
    var body: some View {
        Text("ChatView")
        Button {
            coordinator.moveTo(.chatView2)
        } label: {
            Text("ChatView2")
        }
        Button {
            coordinator.parentMoveAll()
        } label: {
            Text("전부제거")
        }
        Button {
            dismiss()
        } label: {
            Text("dismiss")
        }
    }
}


struct ChatView2: View {
    @Environment(\.dismiss) var dismiss
    
    init() {
        print(#function, #file, "2")
    }
    
    var body: some View {
        Text("ChatView2")
        Button {
            dismiss()
        } label: {
            Text("back")
        }
    }
}

