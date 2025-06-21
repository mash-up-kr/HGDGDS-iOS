//
//  HGTextField.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/21/25.
//

import SwiftUI

public struct HGTextField: View {
    @Environment(\.isEnabled) private var isEnabled: Bool
    @FocusState private var isFocused: Bool
    
    private var title: String?
    private var hiddenClearButton: Bool = false
    private var errorMessage: String?
    private var required: Bool = false
    
    private let size: TextFieldSize
    private let placeholder: String
    private let maxCount: Int?
    
    private var hiddenHelperArea: Bool {
        errorMessage == nil && maxCount == nil
    }
    
    @Binding var text: String
    
    public init(
        text: Binding<String>,
        placeholder: String,
        size: TextFieldSize = .default,
        maxCount: Int? = nil
    ) {
        self.placeholder = placeholder
        self.size = size
        self.maxCount = maxCount
        self._text = text
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            titleArea
            inputArea
            if !hiddenHelperArea { helperArea }
        }
        .if(maxCount != nil) {
            $0.onChange(of: text) { _, newValue in
                guard let maxCount, text.count > maxCount else { return }
                withAnimation(nil) {
                    self.text = String(newValue.prefix(maxCount))
                }
            }
        }
    }
    
    @ViewBuilder
    private var titleArea: some View {
        if let title {
            HStack(spacing: 2) {
                Text(title)
                    .foregroundStyle(HGColors.gray80)
                if required {
                    Text("*")
                        .foregroundStyle(HGColors.orange500Main)
                }
                
                Spacer()
            }
            .setTypo(.caption_12_medium)
            .padding(.bottom, 8)
        }
    }
    
    private var inputArea: some View {
        let state = makeState()
        
        return HStack(spacing: 8) {
            TextField("", text: $text)
                .focused($isFocused)
                .foregroundStyle(.gray95)
                .setTypo(size.font)
                .frame(height: 24)
                .background(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .setTypo(size.font)
                            .foregroundStyle(HGColors.gray30)
                    }
                }
            
            if !hiddenClearButton {
                Button {
                    withAnimation {
                        text.removeAll()
                    }
                } label: {
                    HGIcons.close.image // TODO: #34 병합 이후 다른 아이콘으로 변경 예정
                        .resizable()
                        .frame(24)
                        .foregroundStyle(HGColors.gray40)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 6)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(underLineColor(state: state))
                .frame(height: 1)
        }
    }
    
    private var helperArea: some View {
        HStack(spacing: 8) {
            if let errorMessage {
                Text(errorMessage)
                    .setTypo(.caption_12_medium)
                    .foregroundStyle(.redMain)
            }
            Spacer()
            if let maxCount {
                Text("\(text.count) / \(maxCount)")
                    .setTypo(.caption_12_medium)
                    .foregroundStyle(.gray50)
                    .if(maxCount >= text.count) {
                        $0
                            .contentTransition(.numericText(countsDown: true))
                            .animation(.default, value: text)
                    }
            }
        }
        .padding(.top, 4)
    }
}

// MARK: - Private Method
private extension HGTextField {
    func makeState() -> TextFieldState {
        if !self.isEnabled {
            return .disabled
        }
        
        if self.isFocused {
            return .focused
        }
        
        return .normal
    }
    
    func underLineColor(state: TextFieldState) -> Color {
        switch state {
        case .normal, .disabled, .error:
            return HGColors.gray40.color
        case .focused:
            return HGColors.orange500Main.color
        }
    }
}

public extension HGTextField {
    /// 텍스트필드 위에 텍스트필드 제목을 설정합니다.
    /// - parameter title: 이 텍스트 필드의 제목
    /// - parameter required: 이 텍스트 필드의 입력 필수 여부
    func setTitle(_ title: String?, required: Bool? = nil) -> Self {
        var copy = self
        copy.title = title
        if let required { copy.required = required }
        
        return copy
    }
    
    /// 텍스트필드 클리어 버튼 숨김 여부
    func hideClearButton(_ hidden: Bool) -> Self {
        var copy = self
        copy.hiddenClearButton = hidden
        return copy
    }
    
    /// 에러메시지
    func setErrorMessage(_ message: String?) -> Self {
        var copy = self
        copy.errorMessage = message
        return copy
    }
}

#Preview {
    @Previewable @State var text: String = "123123"
    
    UIFont.registerAllFont()
    
    return HGTextField(
        text: $text,
        placeholder: "닉네임을 입력해주세요",
        size: .default,
        maxCount: 6
    )
    .setTitle("닉네임")
    .setErrorMessage("닉네임은 텍스트만 입력 가능합니다")
    .padding(.horizontal, 16)
}
