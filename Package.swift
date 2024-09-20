// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "KeyboardLayoutGuide",
    platforms: [.iOS(.v12)],
    products: [.library(name: "KeyboardLayoutGuide", targets: ["KeyboardLayoutGuide"])],
    targets: [.target(name: "KeyboardLayoutGuide")]
)
