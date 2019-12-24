// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "KeyboardLayoutGuide",
    platforms: [.iOS(.v9)],
    products: [.library(name: "KeyboardLayoutGuide", targets: ["KeyboardLayoutGuide"])],
    targets: [.target(name: "KeyboardLayoutGuide")]
)
