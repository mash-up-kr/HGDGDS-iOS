// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [
            "Alamofire": .framework,
            "Nuke": .framework,
//            "Lottie": .framework,
            "Firebase": .framework,
            "Swinject": .framework,
        ]
    )
#endif

let package = Package(
    name: "HGDGDS-iOS",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.2"),
//        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.5.1"),
        .package(url: "https://github.com/kean/Nuke.git", from: "12.8.0"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.12.0"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1")
    ]
)
