//
//  UIButton.swift
//  swift-mvvm-pokedex
//
//  Created by João Pedro on 16/02/23.
//

import Foundation
import UIKit

extension UIButton {
    
    /// Set enable for UIButton n change background Color
    /// - Parameter enable: The value for enable/disable UIButton
    func setEnable(enable: Bool) {
        self.isEnabled = enable
        if enable {
            backgroundColor = Colors.pinkColor
        } else {
            backgroundColor = Colors.secondTintColor
        }
    }
}
