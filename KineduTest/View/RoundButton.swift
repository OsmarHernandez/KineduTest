//
//  RoundButton.swift
//  KineduTest
//
//  Created by Osmar Hernández on 13/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
