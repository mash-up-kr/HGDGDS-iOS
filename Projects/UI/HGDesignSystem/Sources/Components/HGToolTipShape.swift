//
//  HGToolTipShape.swift
//  HGDesignSystem
//
//  Created by Enes on 6/30/25.
//

import SwiftUI

#Preview {
    Text("성공")
        .border(.red)
        .background(HGToolTipShape().foregroundStyle(.purpleLight))
        .background(HGToolTipShape().strokeBorder(.orange, lineWidth: 1))
}

public struct HGToolTipShape: Shape, InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        return self
    }
    
    public func path(in rect: CGRect) -> Path {
        let width: CGFloat = rect.width
        let height: CGFloat = rect.height
        let radius: CGFloat = rect.height / 2.0
        let tipCenterX: CGFloat = width * 0.75
        let tipWidth: CGFloat = 7
        let tipHeight: CGFloat = 6
        let curveWidth: CGFloat = 0.9
        let curveHeight: CGFloat = 1
        
        let path = Path { p in
            // 왼쪽 캡슐
            p.addArc(
                center: .init(x: 0, y: radius),
                radius: radius,
                startAngle: .degrees(90),
                endAngle: .degrees(270),
                clockwise: false
            )
            
            // 아랫줄 말풍선 왼쪽 직선부분
            p.move(to: .init(x: 0, y: height))
            p.addLine(to: .init(x: tipCenterX - tipWidth/2, y: height))
            
            // 말풍선
            p.addLine(to: .init(x: tipCenterX-curveWidth, y: height + tipHeight-curveHeight))
            p.addQuadCurve(
                to: .init(x: tipCenterX+curveWidth, y: height + tipHeight-curveHeight),
                control: .init(x: tipCenterX, y: height+tipHeight)
            )
            p.addLine(to: .init(x: tipCenterX + tipWidth/2, y: height))
            
            // 아랫줄 말풍선 오른쪽 직선부분
            p.addLine(to: .init(x: width, y: height))
            
            // 오른쪽 캡슐
            p.addArc(
                center: .init(x: width, y: radius),
                radius: radius,
                startAngle: .degrees(90),
                endAngle: .degrees(270),
                clockwise: true
            )
            
            // 윗줄
            p.addLine(to: .init(x: 0, y: 0))
        }
        
        return path
    }
}


