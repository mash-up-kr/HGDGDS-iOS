//
//  HGLongTextView.swift
//  HGDesignSystem
//
//  Created by Enes on 6/26/25.
//

import SwiftUI

public struct HGLongTextView: View {
    @Binding private var text: String
    private var isFocused: FocusState<Bool>.Binding
    private let title: String
    private let placeholder: String
    private let maxCount: Int
    
    public init(
        text: Binding<String>,
        isFocused: FocusState<Bool>.Binding,
        title: String,
        placeholder: String,
        maxCount: Int
    ) {
        self._text = text
        self.isFocused = isFocused
        self.title = title
        self.placeholder = placeholder
        self.maxCount = maxCount
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            titleView
            Spacer().frame(height: 8)
            textView
            Spacer().frame(height: 4)
            wordCountView
        }
    }
    
    private var titleView: some View {
        HStack {
            Text(title)
                .setTypo(.caption_12_medium)
                .foregroundStyle(.gray80)
            Spacer()
        }
    }
    
    private var textView: some View {
        TextField(placeholder, text: $text, axis: .vertical)
            .setTypo(.body_14_regular)
            .focused(isFocused)
            .lineLimit(5, reservesSpace: true)
            .padding(.horizontal, 16)
            .frame(height: 120)
            .background(.white)
            .strokeBorder(
                isFocused.wrappedValue ? HGColors.orange500Main.color : HGColors.gray40.color,
                radius: 12,
                linewidth: 1
            )
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > maxCount {
                    text = String(newValue.prefix(maxCount))
                }
            }
    }
    
    private var wordCountView: some View {
        HStack {
            Spacer()
            Text("\(text.count) / \(maxCount)")
                .setTypo(.caption_12_regular)
                .foregroundStyle(.gray50)
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    @Previewable @FocusState var isFocused: Bool
    
    VStack {
        HGLongTextView(text: $text, isFocused: $isFocused, title: "설명",placeholder: "입력해주세요",  maxCount: 100)
    }
    .onTapGesture {
        isFocused = false
    }
}
