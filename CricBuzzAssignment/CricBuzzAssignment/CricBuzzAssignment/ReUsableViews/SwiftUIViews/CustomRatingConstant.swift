//
//  CustomRatingConstant.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 02/10/23.
//

import SwiftUI


public enum CustomRatingFillMode {
    case full
    case half
    case precise
}

public enum CustomRatingAxisMode {
    case horizontal
    case vertical
}

public enum CustomRatingValueMode {
    case ratio
    case point
}

public struct CustomRatingConstant: Equatable {
    
    public var rating: Int
    
    public var size: CGSize
    
    public var spacing: CGFloat
    
    public var fillMode: CustomRatingFillMode
    
    public var axisMode: CustomRatingAxisMode
    
    public var valueMode: CustomRatingValueMode
    
    public var disabled: Bool
    
    public var animation: Animation?
    
    public init(rating: Int = 5,
                size: CGSize = CGSize(width: 24, height: 24),
                spacing: CGFloat = 0,
                fillMode: CustomRatingFillMode = .half,
                axisMode: CustomRatingAxisMode = .horizontal,
                valueMode: CustomRatingValueMode = .ratio,
                disabled: Bool = false,
                animation: Animation? = .easeOut(duration: 0.16)) {
        self.rating = rating
        self.size = size
        self.spacing = spacing
        self.fillMode = fillMode
        self.axisMode = axisMode
        self.valueMode = valueMode
        self.disabled = disabled
        self.animation = animation
    }
}
