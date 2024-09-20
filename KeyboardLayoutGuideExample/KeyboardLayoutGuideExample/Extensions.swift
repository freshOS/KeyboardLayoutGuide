//
//  Extensions.swift
//  KeyboardLayoutGuideExample
//
//  Created by Max Konovalov on 27/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let textField = view.subviews.first as? UITextField else {
            return
        }
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        } else {
            textField.becomeFirstResponder()
        }
    }
    
}

class InvertedButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateBackgroundColor()
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        updateBackgroundColor()
    }
    
    private func updateBackgroundColor() {
        backgroundColor = isHighlighted ? tintColor.withAlphaComponent(0.5) : tintColor
    }
    
}
