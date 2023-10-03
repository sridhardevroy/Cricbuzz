//
//  ReusableView.swift
//  CricBuzzAssignment
//
//  Created by Sreedhar Adapala on 27/09/23.
//

import Foundation
import UIKit

/// Object, that adopts this protocol, will use identifier that matches name of its class.
protocol ReusableView: AnyObject {}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReusableView {}
