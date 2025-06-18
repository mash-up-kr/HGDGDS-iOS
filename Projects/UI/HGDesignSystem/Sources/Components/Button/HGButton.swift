//
//  HGButton.swift
//  HGDesignSystem
//
//  Created by iOS신상우 on 6/18/25.
//

import SwiftUI

public struct HGButton: View {
    private let title: String
    
    private let size: HGButtonSize
    private let variant: HGButtonVariant
    private let isMaxWidth: Bool
    private let onTap: (()->Void)?
    
    public init(
        title: String,
        size: HGButtonSize = .large,
        variant: HGButtonVariant = .primary,
        isMaxWidth: Bool = false,
        onTap: (() -> Void)?
    ) {
        self.title = title
        self.size = size
        self.variant = variant
        self.isMaxWidth = isMaxWidth
        self.onTap = onTap
    }
    
    public var body: some View {
        Button {
            onTap?()
        } label: {
            Text(title)
                .frame(maxWidth: isMaxWidth ? .infinity : nil)
        }
        .buttonStyle(HGButtonStyle(size: size, variant: variant))
    }
}

fileprivate struct HGButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    private let size: HGButtonSize
    private let variant: HGButtonVariant
    
    fileprivate init(size: HGButtonSize, variant: HGButtonVariant) {
        self.size = size
        self.variant = variant
    }
    
    func makeBody(configuration: Configuration) -> some View {
        let state = makeState(configuration)
        
        configuration.label
            .setTypo(size.font)
            .foregroundStyle(foregroundColor(state: state, varient: variant))
            .padding(.horizontal, size.hPadding)
            .frame(height: size.height)
            .background(backgroundColor(state: state, varient: variant))
            .clipShape(.capsule)
            .strokeBorder(
                strokeBorderColor(state: state, varient: variant),
                radius: size.height/2,
                linewidth: strokeBorderWidth(varient: variant)
            )
            .scaleEffect(state == .pressed ? 0.95 : 1)
            .animation(.spring(response: 0.35), value: configuration.isPressed)
            
    }
    
    private func makeState(_ configuration: Configuration) -> HGButtonState {
        guard isEnabled else { return .disabled }
        
        if configuration.isPressed {
            return .pressed
        } else {
            return .default
        }
    }
    
    private func backgroundColor(state: HGButtonState, varient: HGButtonVariant) -> Color {
        switch (state, varient) {
        case (.default, .primary):
            return HGColors.orange500Main.color
        case (.disabled, .primary):
            return HGColors.gray30.color
        case (.pressed, .primary):
            return HGColors.orange400.color // TODO: 임시 컬러
        case (.default, .subtle):
            return .clear // TODO: 미정
        case (.disabled, .subtle):
            return .clear // TODO: 미정
        case (.pressed, .subtle):
            return .clear // TODO: 미정
        }
    }
    
    private func foregroundColor(state: HGButtonState, varient: HGButtonVariant) -> Color {
        switch (state, varient) {
        case (_, .primary):
            return HGColors.gray0White.color
        case (.default, .subtle):
            return HGColors.orange500Main.color // TODO: 미정
        case (.disabled, .subtle):
            return HGColors.gray30.color // TODO: 미정
        case (.pressed, .subtle):
            return HGColors.orange500Main.color // TODO: 미정
        }
    }
    
    private func strokeBorderColor(state: HGButtonState, varient: HGButtonVariant) -> Color {
        switch (state, varient) {
        case (_, .primary):
            return .clear
        case (.default, .subtle):
            return HGColors.orange300.color
        case (.disabled, .subtle):
            return HGColors.gray30.color  // TODO: 미정
        case (.pressed, .subtle):
            return HGColors.orange200.color // TODO: 미정
        }
    }
    
    private func strokeBorderWidth(varient: HGButtonVariant) -> CGFloat {
        switch varient {
        case .primary: 0
        case .subtle: 1
        }
    }
}

#Preview {
    @Previewable @State var size: HGButtonSize = .medium
    @Previewable @State var variant: HGButtonVariant = .primary
    @Previewable @State var isEnabled: Bool = false
    
    VStack(spacing: 20) {
        Picker("", selection: $size) {
            ForEach(HGButtonSize.allCases, id: \.rawValue) {
                Text($0.rawValue).tag($0)
            }
        }.pickerStyle(.segmented)
        
        Picker("", selection: $variant) {
            ForEach(HGButtonVariant.allCases, id: \.rawValue) {
                Text($0.rawValue).tag($0)
            }
        }.pickerStyle(.segmented)
        
        Picker("", selection: $isEnabled) {
            Text("Enabled")
                .tag(true)
            Text("Disabled")
                .tag(false)
        }.pickerStyle(.segmented)
        
        HGButton(title: "Label", size: size, variant: variant, isMaxWidth: true, onTap: { })
            .disabled(!isEnabled)
        
        HGButton(title: "Label", size: size, variant: variant, isMaxWidth: false, onTap: { })
            .disabled(!isEnabled)
    }
    .padding()
}
