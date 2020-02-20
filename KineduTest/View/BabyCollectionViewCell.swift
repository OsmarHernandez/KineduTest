//
//  BabyCollectionViewCell.swift
//  KineduTest
//
//  Created by Osmar Hernández on 18/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class BabyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var babyImageView: UIImageView!
    @IBOutlet weak var babyScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpLabelFonts([babyScoreLabel])
    }
    
    func highlightSelectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.babyImageView.layer.masksToBounds = true
            self.babyImageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.babyImageView.layer.borderWidth = 5
            self.babyImageView.layer.cornerRadius = self.babyImageView.bounds.width / 2
        }
    }
    
    func unhighlightDeselectedCell() {
        UIView.animate(withDuration: 0.3) {
            self.babyImageView.layer.masksToBounds = true
            self.babyImageView.layer.borderColor = UIColor.clear.cgColor
            self.babyImageView.layer.borderWidth = 0
            self.babyImageView.layer.cornerRadius = 0
        }
    }
}
