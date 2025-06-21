//
//  PreviewFontModifier.swift
//  HGDesignSystem
//
//  Created by Enes on 6/21/25.
//

import SwiftUI

/**
 프리뷰 환경설정을 담당합니다
 ``` swift
 #Preview(traits: .applyFont) {
     MyPageView()
 }
 ```
 */
struct PreviewFontModifier: PreviewModifier {
    init() {
        UIFont.registerAllFont()
    }
    
    func body(content: Content, context: Void) -> some View {
            content
    }
}

public extension PreviewTrait where T == Preview.ViewTraits {
    /// 프리뷰환경에서 폰트를 적용시킵니다
    static var applyFont: Self = .modifier(PreviewFontModifier())
}
