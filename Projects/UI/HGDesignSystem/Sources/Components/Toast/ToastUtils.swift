//
//  ToastUtils.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 7/1/25.
//

import SwiftUI

/**
 토스트 사용 방법
 ToastUtils.showToast("토스트 메세지")
 */
@MainActor
public struct ToastUtils {
    static public func showToast(
        _ title: String,
        icon: HGIcons? = nil,
        totalDuration: CGFloat = 2.5
    ) {
        ToastWindowManager.shared.show(duration: totalDuration) {
            HGToastView(title: title, icon: icon, totalDuration: totalDuration)
        }
    }
}
