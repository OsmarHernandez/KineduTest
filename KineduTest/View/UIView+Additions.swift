//
//  UIView+Additions.swift
//  KineduTest
//
//  Created by Osmar Hernández on 18/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

extension UIView {

    func configureShadowBackground() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
    }
    
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    
    private func setCustomFont(_ pointSize: CGFloat) -> CGFloat {
        let bounds = UIScreen.main.bounds
        let width = bounds.size.width
        
        let baseWidth: CGFloat = 375
        
        let fontSize = pointSize * (width / baseWidth)
        
        return fontSize
    }
    
    func setUpLabelFonts(_ labels: [UILabel]) {
        for label in labels {
            let fontName = label.font.fontName
            let pointSize = label.font.pointSize
            
            label.font = UIFont(name: fontName, size: label.setCustomFont(pointSize))
        }
    }
}
