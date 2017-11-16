//
//  Keyboard+LayoutGuide.swift
//  KeyboardLayoutGuide
//
//  Created by Sacha DSO on 14/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit


public class KeyboardLayoutGuide: UILayoutGuide {
    
    private var token: NSKeyValueObservation? = nil
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init() {
        super.init()
        
        // Observe keyboardWillShow and keyboardWillHide notifications.
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(keyboardWillShow(_:)),
                       name: .UIKeyboardWillShow,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(keyboardWillHide(_:)),
                       name: .UIKeyboardWillHide,
                       object: nil)
        
        // Observe owningView so that we can setup our layoutGuide
        // once the user has called `view.addLayoutGuide`
        token = observe(\.owningView) { object, _ in
            if let view = object.owningView {
                object.setUp(inView: view)
            }
        }
    }
    
    private func setUp(inView view: UIView) {
        heightAnchor.constraint(equalToConstant: 0).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        let viewBottomAnchor: NSLayoutYAxisAnchor!
        if #available(iOS 11.0, *) {
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewBottomAnchor = view.bottomAnchor
        }
        bottomAnchor.constraint(equalTo: viewBottomAnchor).isActive = true
    }
    
    @objc
    func keyboardWillShow(_ note: Notification) {
        if var height = note.keyboardHeight {
            if #available(iOS 11.0, *) {
                height -= (owningView?.safeAreaInsets.bottom)!
            }
            heightConstraint?.constant = height
            animate(note)
        }
    }
    
    @objc
    func keyboardWillHide(_ note: Notification) {
        heightConstraint?.constant = 0
        animate(note)
    }
    
    private func animate(_ note: Notification) {
        if isVisible(view: self.owningView!) {
            self.owningView?.layoutIfNeeded()
        } else {
            UIView.performWithoutAnimation {
                self.owningView?.layoutIfNeeded()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Helpers

extension UILayoutGuide {
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
    var keyboardHeight: CGFloat? {
        guard let v = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        return v.cgRectValue.size.height
    }
}

// Credits to John Gibb for this nice helper :)
// https://stackoverflow.com/questions/1536923/determine-if-uiview-is-visible-to-the-user
func isVisible(view: UIView) -> Bool {
    func isVisible(view: UIView, inView: UIView?) -> Bool {
        guard let inView = inView else { return true }
        let viewFrame = inView.convert(view.bounds, from: view)
        if viewFrame.intersects(inView.bounds) {
            return isVisible(view: view, inView: inView.superview)
        }
        return false
    }
    return isVisible(view: view, inView: view.superview)
}

