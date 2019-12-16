//
//  Keyboard+LayoutGuide.swift
//  KeyboardLayoutGuide
//
//  Created by Sacha DSO on 14/11/2017.
//  Copyright © 2017 freshos. All rights reserved.
//

import UIKit

internal class Keyboard {
    static let shared = Keyboard()
    var currentHeight: CGFloat = 0
}

extension UIView {
    private enum Identifiers {
        static var usingSafeArea = "KeyboardLayoutGuideUsingSafeArea"
        static var notUsingSafeArea = "KeyboardLayoutGuide"
    }

    /// A layout guide representing the inset for the keyboard.
    /// Use this layout guide’s top anchor to create constraints pinning to the top of the keyboard or the bottom of safe area.
    public var keyboardLayoutGuide: UILayoutGuide {
        getOrCreateKeyboardLayoutGuide(identifier: Identifiers.usingSafeArea, usesSafeArea: true)
    }

    /// A layout guide representing the inset for the keyboard.
    /// Use this layout guide’s top anchor to create constraints pinning to the top of the keyboard or the bottom of the view.
    public var keyboardLayoutGuideNoSafeArea: UILayoutGuide {
        getOrCreateKeyboardLayoutGuide(identifier: Identifiers.notUsingSafeArea, usesSafeArea: false)
    }

    private func getOrCreateKeyboardLayoutGuide(identifier: String, usesSafeArea: Bool) -> UILayoutGuide {
        if let existing = layoutGuides.first(where: { $0.identifier == identifier }) {
            return existing
        }
        let new = KeyboardLayoutGuide()
        new.usesSafeArea = usesSafeArea
        new.identifier = identifier
        addLayoutGuide(new)
        new.setUp()
        return new
    }
}

open class KeyboardLayoutGuide: UILayoutGuide {
    public var usesSafeArea = true {
        didSet {
            updateButtomAnchor()
        }
    }

    private var bottomConstraint: NSLayoutConstraint?

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public init(notificationCenter: NotificationCenter = NotificationCenter.default) {
        super.init()
        // Observe keyboardWillChangeFrame notifications
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    internal func setUp() {
        guard let view = owningView else { return }
        NSLayoutConstraint.activate(
            [
                heightAnchor.constraint(equalToConstant: Keyboard.shared.currentHeight),
                leftAnchor.constraint(equalTo: view.leftAnchor),
                rightAnchor.constraint(equalTo: view.rightAnchor),
            ]
        )
        updateButtomAnchor()
    }

    func updateButtomAnchor() {
        if let bottomConstraint = bottomConstraint {
            bottomConstraint.isActive = false
        }

        guard let view = owningView else { return }

        let viewBottomAnchor: NSLayoutYAxisAnchor
        if #available(iOS 11.0, *), usesSafeArea {
            viewBottomAnchor = view.safeAreaLayoutGuide.bottomAnchor
        } else {
            viewBottomAnchor = view.bottomAnchor
        }

        bottomConstraint = bottomAnchor.constraint(equalTo: viewBottomAnchor)
        bottomConstraint?.isActive = true
    }

    @objc
    private func keyboardWillChangeFrame(_ note: Notification) {
        if var height = note.keyboardHeight, let duration = note.animationDuration {
            if #available(iOS 11.0, *), usesSafeArea, height > 0, let bottom = owningView?.safeAreaInsets.bottom {
                height -= bottom
            }
            heightConstraint?.constant = height
            if duration > 0.0 {
                animate(note)
            }
            Keyboard.shared.currentHeight = height
        }
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
        // Weirdly enough UIKeyboardFrameEndUserInfoKey doesn't have the same behaviour
        // in ios 10 or iOS 11 so we can't rely on v.cgRectValue.width
        let screenHeight = UIApplication.shared.keyWindow?.bounds.height ?? UIScreen.main.bounds.height
        return screenHeight - keyboardFrame.cgRectValue.minY
    }
    
    var animationDuration: CGFloat? {
        return self.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat
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
