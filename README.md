# ⌨️ KeyboardLayoutGuide
*Apple's missing KeyboardLayoutGuide*

[![Language: Swift 4](https://img.shields.io/badge/language-swift4-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 9+](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/Keyboard+LayoutGuide)
[![License: MIT](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](https://github.com/s4cha/Stevia/blob/master/LICENSE)
[![GitHub tag](https://img.shields.io/github/release/freshos/KeyboardLayoutGuide.svg)](https://github.com/freshOS/KeyboardLayoutGuide/releases)


- [x] No Subclassing / Protocol inheritance / obscure overrides
- [x] No more keyboard notification handling
- [x] `UIKit` Friendly
- [x] Takes `safeArea` into account
- [x] Only animates if view is fully on screen

<img src="Images/demo.gif" width=250>

## How to use it

Simply constrain your views to the KeyboardLayoutGuide's top anchor the way you would do natively:


```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    // Pin your button to the keyboard
    button.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
}
```

If you add your view in Interface Builder, don't forget to enable the "**Remove at build time**" checkbox for the bottom constraint:

<img src="Images/constraint.png" width=258>

## Installation

### CocoaPods

To install `KeyboardLayoutGuide` via [CocoaPods](http://cocoapods.org), add the following line to your Podfile:

```
target 'MyAppName' do
  pod 'Keyboard+LayoutGuide'
  use_frameworks!
end
```

### Carthage

To install `KeyboardLayoutGuide` via [Carthage](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos), add the following line to your Cartfile:

```
github "freshos/KeyboardLayoutGuide"
```

### Manually
Just add `Keyboard+LayoutGuide.swift` to your Xcode project.

## License

`KeyboardLayoutGuide` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
