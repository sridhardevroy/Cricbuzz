//
//  CustomRatingControl.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 02/10/23.
//

import SwiftUI

public struct CustomRatingControl<B, F>: View where B: View, F: View {
    
    @Binding private var value: CGFloat
    
    private var constant: CustomRatingConstant
    
    @ViewBuilder private var backV: () -> B
    
    @ViewBuilder private var foreV: () -> F
    
    public var body: some View {
        ZStack(alignment: .topLeading) {
            backgroundView
            foregroundView.mask(maskView)
        }
        .animation(constant.animation, value: value)
    }
    
    //MARK: - Properties
    
    private var ratioValue: CGFloat {
        if constant.valueMode == .point {
            return value / CGFloat(constant.rating)
        }
        return value
    }
    
    
    private var barSize: CGFloat {
        if constant.axisMode == .horizontal {
            return CGFloat(constant.rating) * (constant.size.width + constant.spacing)
        }else {
            return CGFloat(constant.rating) * (constant.size.height + constant.spacing)
        }
    }
    
    private var backgroundView: some View {
        var views: some View {
            ForEach(0..<constant.rating, id: \.self) { index in
                HStack(alignment: .center) {
                    backV().frame(width: constant.size.width, height: constant.size.height)
                }
            }
        }
        return ZStack {
            if constant.axisMode == .horizontal {
                HStack(spacing: 0) {
                    views
                        .frame(width: constant.size.width + constant.spacing, height: constant.size.height)
                }
                .frame(width: barSize)
            }else {
                VStack(spacing: 0) {
                    views
                        .frame(width: constant.size.width, height: constant.size.height + constant.spacing)
                }
                .frame(height: barSize)
            }
        }
        .contentShape(Rectangle())
    }
    
    private var foregroundView: some View {
        var views: some View {
            ForEach(0..<constant.rating, id: \.self) { index in
                HStack(alignment: .center) {
                    foreV().frame(width: constant.size.width, height: constant.size.height)
                }
            }
        }
        return ZStack {
            if constant.axisMode == .horizontal {
                HStack(spacing: 0) {
                    views
                        .frame(width: constant.size.width + constant.spacing, height: constant.size.height)
                }
                .frame(width: barSize)
            }else {
                VStack(spacing: 0) {
                    views
                        .frame(width: constant.size.width, height: constant.size.height + constant.spacing)
                }
                .frame(height: barSize)
            }
        }
        .contentShape(Rectangle())
    }
    
    private var maskView: some View {
        Rectangle()
            .fill(Color.white)
            .scaleEffect(constant.axisMode == .horizontal ? CGSize(width: ratioValue, height: 1) : CGSize(width: 1, height: ratioValue), anchor: constant.axisMode == .horizontal ? .leading : .bottom)
    }
}

public extension CustomRatingControl where B : View, F : View  {
    
    init(value: Binding<CGFloat>, constant: CustomRatingConstant = .init(), @ViewBuilder background: @escaping () -> B, @ViewBuilder foreground: @escaping () -> F) {
        _value = value
        self.constant = constant
        self.backV = background
        self.foreV = foreground
    }
}

struct CustomRatingControl_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomRatingControl(value: .constant(0.5), constant: .init()) {
                CustomRatingStar(count: 6, innerRatio: 1)
                    .fill(Color.gray)
            } foreground: {
                CustomRatingStar(count: 6, innerRatio: 1)
                    .fill(Color.accentColor)
            }
            
            CustomRatingControl(value: .constant(0.5), constant: .init(axisMode: .vertical)) {
                CustomRatingStar(count: 6, innerRatio: 1)
                    .fill(Color.gray)
            } foreground: {
                CustomRatingStar(count: 6, innerRatio: 1)
                    .fill(Color.accentColor)
            }
        }
    }
}

