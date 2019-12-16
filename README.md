# ⌨️ KeyboardLayoutGuide
*Apple's missing KeyboardLayoutGuide*

[![Language: Swift 5](https://img.shields.io/badge/language-swift5-f48041.svg?style=flat)](https://developer.apple.com/swift)
![Platform: iOS 9+](https://img.shields.io/badge/platform-iOS-blue.svg?style=flat)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/pods/Keyboard+LayoutGuide)
[![Build Status](https://app.bitrise.io/app/0c1de450af273bff/status.svg?token=UpT-2PFMgu6h_RMRJW7PMQ&branch=master)](https://app.bitrise.io/app/0c1de450af273bff)
[![codebeat badge](https://codebeat.co/badges/8e52bcad-c73b-4d19-83b9-7af8464a288e)](https://codebeat.co/projects/github-com-freshos-keyboardlayoutguide-master)
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

**Bonus**: if you're using [Stevia](https://github.com/freshOS/Stevia), this gets even more concise \o/
```swift
button.Bottom == view.keyboardLayoutGuide.Top
```

If you add your view in Interface Builder, don't forget to enable the "**Remove at build time**" checkbox for the bottom constraint:

<img src="Images/constraint.png" width=258>

## Safe Area
By default, KeyboardLayoutGuide will align your item with the bottom safe area.
This is a behaviour that can be opt out by using `keyboardLayoutGuideNoSafeArea` instead of `keyboardLayoutGuide`.

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

### Swift Package Manager

To integrate `KeyboardLayoutGuide` via [SPM](https://swift.org/package-manager/) into your Xcode 11 project specify it in Project > Swift Packages:
```
https://github.com/freshOS/KeyboardLayoutGuide
```

### Manually
Just add `Keyboard+LayoutGuide.swift` to your Xcode project.

## License

`KeyboardLayoutGuide` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
