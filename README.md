# ⌨️ KeyboardLayoutGuide
*Apple's missing KeyboardLayoutGuide*

[![Language: Swift 4](https://img.shields.io/badge/language-swift4-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 9+](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/Keyboard+LayoutGuide)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/s4cha/Stevia/blob/master/LICENSE)
 [![Release version](https://img.shields.io/badge/release-1.1-blue.svg)]()


- [x] No Subclassing / Protocol inheritance / obscure overrides
- [x] No more keyboard notification handling
- [x] `UIKit` Friendly
- [x] Takes `safeArea` into account
- [x] Only animates if view is fully on screen

```swift
button.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor).isActive = true
```
*Constrain your button to the keyboardLayoutGuide's top Anchor the way you would do natively :) *
