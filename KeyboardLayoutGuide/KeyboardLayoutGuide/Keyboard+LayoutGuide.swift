//
//  Keyboard+LayoutGuide.swift
//  KeyboardLayoutGuide
//
//  Created by Sacha DSO on 14/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit

private class Keyboard {
    static let shared = Keyboard()
    var currentHeight: CGFloat = 0
}

extension UIView {
    private enum AssociatedKeys {
        static var keyboardLayoutGuide = "keyboardLayoutGuide"
    }
    
    // A layout guide representing the inset for the keyboard.
    // Use this layout guide’s top anchor to create constraints pinning to the top of the keyboard.
    public var keyboardLayoutGuide: KeyboardLayoutGuide {
        if let obj = objc_getAssociatedObject(self, &AssociatedKeys.keyboardLayoutGuide) as? KeyboardLayoutGuide {
            return obj
        }
        let new = KeyboardLayoutGuide()
        addLayoutGuide(new)
        new.setUp()
        objc_setAssociatedObject(self, &AssociatedKeys.keyboardLayoutGuide, new as Any, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return new
    }
}

open class KeyboardLayoutGuide: UILayoutGuide {
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        super.init()
        // Observe keyboardWillChangeFrame notifications
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    internal func setUp() {
        guard let view = owningView else { return }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Keyboard.shared.currentHeight),
            leftAnchor.constraint(equalTo: view.leftAnchor),
            rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        
        let viewBottomAnchor: NSLayoutYAxisAnchor
        
        if #available(iOS 11.0, *) {
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewBottomAnchor = view.bottomAnchor
        }
        
        bottomAnchor.constraint(equalTo: viewBottomAnchor).isActive = true
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if var height = notification.keyboardHeight {
            if #available(iOS 11.0, *), height > 0, let bottom = owningView?.safeAreaInsets.bottom {
                height -= bottom
            }
            heightConstraint?.constant = height
            animate(notification)
            Keyboard.shared.currentHeight = height
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
            heightConstraint?.constant = 0
            animate(notification)
            Keyboard.shared.currentHeight = 0
    }
    
    private func animate(_ note: Notification) {
        if
            let owningView = self.owningView,
            isVisible(view: owningView)
        {
            self.owningView?.layoutIfNeeded()
        } else {
            UIView.performWithoutAnimation {
                self.owningView?.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Helpers
extension UILayoutGuide {
    internal var heightConstraint: NSLayoutConstraint? {
        return owningView?.constraints.first {
            $0.firstItem as? UILayoutGuide == self && $0.firstAttribute == .height
        }
    }
}

extension Notification {
    var keyboardHeight: CGFloat? {
        guard let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return nil
        }
        
        return keyboardFrame.cgRectValue.height
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
