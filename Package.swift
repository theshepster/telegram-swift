import PackageDescription

let package = Package(
    name: "telegram-swift",
    dependencies: [
      .Package(url: "https://github.com/theshepster/SwiftyJSON.git", Version(11,1,0))
    ]
)

