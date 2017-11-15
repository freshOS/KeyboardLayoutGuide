//
//  Keyboard+LayoutGuide.swift
//  KeyboardLayoutGuide
//
//  Created by Sacha DSO on 14/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit


public class KeyboardLayoutGuide: UILayoutGuide {
    
    private var height: CGFloat = 0
    private var token: NSKeyValueObservation? = nil
    private var token2: NSKeyValueObservation? = nil
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init() {
        super.init()
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(keyboardWillShow(_:)),
                       name: .UIKeyboardWillShow,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(keyboardWillHide(_:)),
                       name: .UIKeyboardWillHide,
                       object: nil)
        
        
        token = observe(\.owningView) { [weak self] object, _ in
            if let view = object.owningView {
                object.setUp(inView: view)
                self?.token2 = view.observe(\.safeAreaInsets) { object, change in
                    self?.viewSafeAreaInsetsDidChange()
                }
            }
            
        }
    }
    
    private func setUp(inView view: UIView) {
        if #available(iOS 11.0, *) {
            height = view.safeAreaInsets.bottom
        } else {
            height = 0
        }
        heightAnchor.constraint(equalToConstant: height).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            height = owningView?.safeAreaInsets.bottom ?? 0
        }
        updateHeightConstraint()
    }
    
    @objc
    func keyboardWillShow(_ note: Notification) {
        height = note.keyboardHeight ?? height
        updateHeightConstraint()
        animate(note)
    }
    
    @objc
    func keyboardWillHide(_ note: Notification) {
        if #available(iOS 11.0, *) {
            height = owningView?.safeAreaInsets.bottom ?? 0
        } else {
            height = 0
        }
        updateHeightConstraint()
        animate(note)
    }
    
    private func updateHeightConstraint() {
        heightConstraint?.constant = height
    }
    
    private func animate(_ note: Notification) {
        guard let animationDuration = note.animationDuration,
            let animationCurve = note.animationCurve else {
                return
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            self.owningView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Helpers

public extension UILayoutGuide {
    var heightConstraint: NSLayoutConstraint? {
        guard let target = owningView else { return nil }
        for c in target.constraints {
            if let fi = c.firstItem as? UILayoutGuide, fi == self && c.firstAttribute == .height {
                return c
            }
        }
        return nil
    }
}

extension Notification {

    var animationDuration: TimeInterval? {
        return (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double)
    }

    var animationCurve: UIViewAnimationOptions? {
        guard let value = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int) else {
            return nil
        }
        return UIViewAnimationOptions(rawValue: UInt(value))
    }

    var keyboardHeight: CGFloat? {
        guard let v = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        return v.cgRectValue.size.height
    }
}

