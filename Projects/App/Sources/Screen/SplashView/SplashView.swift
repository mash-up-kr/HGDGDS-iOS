//
//  SplashView.swift
//  HGDGDS-iOS
//
//  Created by iOS신상우 on 7/8/25.
//

import SwiftUI
import HGDesignSystem

struct SplashView: View {
    
    var body: some View {
        ZStack {
            HGImages.kokkokLogo.image
                .foregroundStyle(.white)
        }
        .fillMaxSize(.center)
        .background {
            HGImages.splashBackground.image
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()       
        }
    }
}

#Preview {
    SplashView()
}
