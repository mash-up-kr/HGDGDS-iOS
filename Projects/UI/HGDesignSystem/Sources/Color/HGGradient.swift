//
//  HGGradient.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/15/25.
//

import SwiftUI

public enum HGGradient {
    public static let orangeMain: LinearGradient = .init(
        colors: [.init(hex: "FF710C"), .init(hex: "FEB66E")],
        startPoint: .top,
        endPoint: .bottom
    )
    public static let orangeMain2: LinearGradient = .init(
        colors: [.init(hex: "FEB66E"), .init(hex: "FF710C")],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let orangeLight: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "FFAE82"), location: 0),
            .init(color: .init(hex: "FFDBCE"), location: 0.2),
            .init(color: .init(hex: "FFFBF9"), location: 0.9),
            .init(color: .init(hex: "F6F6F7"), location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let orangeSub: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "FE6A30"), location: 0),
            .init(color: .init(hex: "FFEEE6"), location: 0.8),
            .init(color: HGColors.gray10.color, location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let purpleMain: LinearGradient = .init(
        colors: [.init(hex: "7C5BFF"), .init(hex: "89A7F9")],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let purpleLight: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "A69AFF"), location: 0),
            .init(color: .init(hex: "C2C2FF"), location: 0.2),
            .init(color: .init(hex: "F3F8FE"), location: 0.9),
            .init(color: .init(hex: "F6F6F7"), location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let purpleSub: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "7C5BFF"), location: 0),
            .init(color: .init(hex: "ECECFF"), location: 0.8),
            .init(color: HGColors.gray10.color, location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    public static let greenMain: LinearGradient = .init(
        colors: [.init(hex: "0FC24D"), .init(hex: "C9E86C")],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let greenLight: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "65D88D"), location: 0),
            .init(color: .init(hex: "BEF2D0"), location: 0.2),
            .init(color: .init(hex: "EEFBF2"), location: 0.9),
            .init(color: .init(hex: "F6F6F7"), location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let greenSub: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "0FC24D"), location: 0),
            .init(color: .init(hex: "E9F7EE"), location: 0.8),
            .init(color: HGColors.gray10.color, location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let blueMain: LinearGradient = .init(
        colors: [.init(hex: "2B8BFF"), .init(hex: "57DFE2")],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let blueLight: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "A3CCFF"), location: 0),
            .init(color: .init(hex: "D6E7FC"), location: 0.2),
            .init(color: .init(hex: "F4F9FE"), location: 0.9),
            .init(color: .init(hex: "F6F6F7"), location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let blueSub: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "2B8BFF"), location: 0),
            .init(color: .init(hex: "E6F1FD"), location: 0.8),
            .init(color: .init(hex: "F6F6F7"), location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    public static let pinkMain: LinearGradient = .init(
        colors: [.init(hex: "FC4F92"), .init(hex: "FF86AE")],
        startPoint: .top,
        endPoint: .bottom
    )

    public static let pinkLight: LinearGradient = .init(
        stops: [
            .init(color: .init(hex: "FD9FC3"), location: 0),
            .init(color: .init(hex: "FEDAE8"), location: 0.2),
            .init(color: .init(hex: "FFFAFC"), location: 0.9),
            .init(color: .init(hex: "F6F6F7"), location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let pinkSub: LinearGradient = .init(
        stops: [
            .init(color: HGColors.pinkMain.color, location: 0),
            .init(color: HGColors.pinkLight.color, location: 0.8),
            .init(color: HGColors.gray10.color, location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    public static let strok30: some View = LinearGradient(
        stops: [
            .init(color: .init(hex: "FFFFFF"), location: 0),
            .init(color: .init(hex: "FFFFFF").opacity(0.5), location: 0.5),
            .init(color: .init(hex: "FFFFFF").opacity(0.8), location: 1),
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    ).opacity(0.3)
}

#Preview {
    ScrollView {
        Grid {
            Group {
                GridRow {
                    HGGradient.orangeMain
                    HGGradient.orangeMain2
                    HGGradient.orangeLight
                    HGGradient.orangeSub
                }
                
                GridRow {
                    HGGradient.purpleMain
                    HGGradient.purpleLight
                    HGGradient.purpleSub
                }
                
                GridRow {
                    HGGradient.greenMain
                    HGGradient.greenLight
                    HGGradient.greenSub
                }
                
                GridRow {
                    HGGradient.blueMain
                    HGGradient.blueLight
                    HGGradient.blueSub
                }
                
                GridRow {
                    HGGradient.pinkMain
                    HGGradient.pinkLight
                    HGGradient.pinkSub
                }
                
                GridRow {
                    HGGradient.strok30
                }
                .background(Color.black)
            }
            .aspectRatio(1, contentMode: .fill)
        }
    }
    .padding()
}
