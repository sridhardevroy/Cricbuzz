//
//  CustomRatingStar.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 02/10/23.
//

import SwiftUI

/// A star shape.
public struct CustomRatingStar: Shape {
    
    var count: CGFloat
    var innerRatio: CGFloat
    
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(count, innerRatio) }
        set {
            count = newValue.first
            innerRatio = newValue.second
        }
    }
    
    public init(count: CGFloat, innerRatio: CGFloat) {
        self.count = count
        self.innerRatio = innerRatio
    }
    
    public func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5)
        let pointAngle = .pi / count
        
        let innerPoint = CGPoint(x: center.x * innerRatio * 0.5, y: center.y * innerRatio * 0.5)
        let totalPoints = Int(count * 2.0)
        
        var currentAngle = CGFloat.pi * -0.5
        var currentBottom: CGFloat = 0
        
        var path = Path()
        path.move(to: CGPoint(x: center.x * cos(currentAngle),
                              y: center.y * sin(currentAngle)))
        
        let correction = count != round(count) ? 1 : 0
        for corner in 0..<totalPoints + correction  {
            var bottom: CGFloat = 0
            let sin = sin(currentAngle)
            let cos = cos(currentAngle)
            if (corner % 2) == 0 {
                bottom = center.y * sin
                path.addLine(to: CGPoint(x: center.x * cos, y: bottom))
            } else {
                bottom = innerPoint.y * sin
                path.addLine(to: CGPoint(x: innerPoint.x * cos, y: bottom))
            }
            currentBottom = max(bottom, currentBottom)
            currentAngle += pointAngle
        }
        path.closeSubpath()
        let transform = CGAffineTransform(translationX: center.x, y: center.y + ((rect.height * 0.5 - currentBottom) * 0.5))
        return path.applying(transform)
    }
}


struct CustomRatingStar_Previews: PreviewProvider {
    static var previews: some View {
        CustomRatingStar(count: 5, innerRatio: 1)
            .frame(width: 200, height: 200)
    }
}

