//
//  CustomSegmentedControl.swift
//  KineduTest
//
//  Created by Osmar Hernández on 18/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIView {
    
    private var buttonTittles: [String]!
    private var buttons: [UIButton]!
    
    private var index: Int!
    
    @IBInspectable var segmentTitleColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBInspectable var segmentBackgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    @IBInspectable var selectedTitleColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    @IBInspectable var selectedBackgroundColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    @IBInspectable var segmentBorderColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    @IBInspectable var segments: String = "First, Second" {
        didSet {
            let titles = segments.replacingOccurrences(of: " ", with: "").components(separatedBy: ",")
            setUpButtonTittles(titles.sorted { $0 < $1 })
        }
    }
    
    init(frame: CGRect, tittles: [String]) {
        super.init(frame: frame)
        setUpButtonTittles(tittles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButtonTittles(["First, Second"])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 343, height: 30)
    }
    
    func setUpButtonTittles(_ tittles: [String]) {
        self.buttonTittles = tittles
    }
    
    var titleForSelectedSegment: String? {
        return buttonTittles.isEmpty ? nil : buttonTittles[index]
    }
    
    var actionForSelectedSegment: (UIButton) -> Void = { _ in }
    
    private func updateView() {
        guard let _ = buttonTittles else { return }
        
        createButtons()
        configureStackView()
    }
}

extension CustomSegmentedControl {
    
    private func configureStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        
        addSubview(stack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    private func createButtons() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        for buttonTitle in buttonTittles {
            let button = UIButton(type: .system)
            configureUnselectedButton(button)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont(name: "GothamRounded-Medium", size: 17)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            button.layer.borderColor = segmentBorderColor.cgColor
            button.layer.borderWidth = 1
            buttons.append(button)
        }
        
        buttons.first?.roundCorners(with: [.layerMinXMaxYCorner, .layerMinXMinYCorner], radius: 5)
        buttons.last?.roundCorners(with: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 5)
        configureSelectedButton(buttons.first!)
        index = 0
    }
    
    private func configureUnselectedButton(_ button: UIButton) {
        button.setTitleColor(segmentTitleColor, for: .normal)
        button.backgroundColor = segmentBackgroundColor
    }
    
    @objc private func buttonAction(sender: UIButton) {
        configureUnselectedButton(buttons[index])
        configureSelectedButton(sender)
    }
    
    private func configureSelectedButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.3) {
            button.backgroundColor = self.selectedBackgroundColor
            button.setTitleColor(self.selectedTitleColor, for: .normal)
            self.index = self.buttons.index(of: button)
            self.actionForSelectedSegment(button)
        }
    }
}
