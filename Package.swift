import PackageDescription

let package = Package(
    name: "telegram-bot-swift",
    dependencies: [
      .Package(url: "https://github.com/zmeyc/SwiftyJSON.git", versions: "2.3.3" ..< Version.max)
    ]
)

