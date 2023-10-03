//
//  CustomRatingView.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 02/10/23.
//

import SwiftUI

struct CustomRatingView: View {
    
    @State private var axisMode: CustomRatingAxisMode = .horizontal
    @State private var starCount: CGFloat = 10
    @State private var innerRatio: CGFloat = 1
    @State private var spacing: CGFloat = 6
    @State private var fillMode: CustomRatingFillMode = .precise
    
    @Binding var currentRating: CGFloat

    
    @State private var selection: Int = 0
    
    private var content: some View {
        let constant1 = CustomRatingConstant(rating: 10
                                   ,
                                   size: CGSize(width: 24, height: 24),
                                   spacing: spacing,
                                   fillMode: fillMode,
                                   axisMode: axisMode,
                                   valueMode: .point)
        
        return Group {
            VStack {
                Text("\(currentRating, specifier: "%.2f")")
                CustomRatingControl(value: $currentRating, constant: constant1) {
                    CustomRatingStar(count: round(starCount), innerRatio: innerRatio)
                        .stroke()
                        .fill(Color.gray)
                } foreground: {
                    CustomRatingStar(count: round(starCount), innerRatio: innerRatio)
                        .fill(Color.accentColor)
                }
            }
        }
    }
    var body: some View {
        VStack {
            Spacer()
            if axisMode == .horizontal {
                VStack(alignment: .center) {
                    content
                        .padding(.bottom)
                        .background(Color.clear)
                }
            }else {
                HStack(alignment: .bottom) {
                    content
                        .padding(.bottom)
                        .background(Color.clear)
                }
            }
            Spacer()
            
        }
        .padding()
        .animation(.easeInOut, value: starCount)
        .animation(.easeInOut, value: innerRatio)
        .background(Color.clear)
    }
}

struct CustomRatingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomRatingView(currentRating: .constant(7.8))
    }
}

