//
//  BookingView.swift
//  Booking
//
//  Created by  on .
//

import SwiftUI

struct BookingView: View {
    @Environment(\.dismiss) var dismiss
    init() {
        print(#function, #file)
    }
    
    var body: some View {
        Text("BookingView")
        
        Button {
            dismiss()
        } label: {
            Text("back")
        }
    }
}
