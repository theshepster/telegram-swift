import PackageDescription

let package = Package(
    name: "telegram-bot-swift",
    dependencies: [
      .Package(url: "https://github.com/theshepster/SwiftyJSON.git", versions: "2.2.0" ..< Version.max)
    ]
)

