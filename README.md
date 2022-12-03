# Swift ISP Kit

ISP Kit is a Swift language SDK for ISP, working on Linux, macOS and iOS. This library provides access to  ISP services.

## Swift Package Manager

ISP Kit uses the Swift Package Manager to manage its code dependencies. To use ISP Kit in your codebase it is
recommended you do the same. Add a dependency to the package in your own Package.swift dependencies.

```swift
    dependencies: [
        .package(url: "https://github.com/adamayoung/isp-kit.git", from: "0.1.0")
    ],
```

Then add target dependencies for each of the ISP Kit targets you want to use.

```swift
    targets: [
        .target(name: "MyApp", dependencies: [
            .product(name: "SCAN", package: "isp-kit"),
            .product(name: "SMP", package: "isp-kit"),
            .product(name: "CMS", package: "isp-kit")
        ]),
    ]
)
```

or

```swift
    targets: [
        .target(name: "MyApp", dependencies: [
            .product(name: "Sportsbook", package: "isp-kit")
        ]),
    ]
)
```

Alternatively if you are using Xcode 11 or later you can use the Swift Package Manager integration and add a dependency
to ISP Kit through that.

## Using ISP Kit

To use ISP Kit you need to create a `Client` and a service object for the ISP service you want to work with. The
`Client` provides all the communication with ISP and the service object provides the configuration and APIs for
communicating with a specific ISP service.

```swift
import SMP //ensure this module is specified as a dependency in your Package.swift

let client = GBPClient(
    applicationID: "<GBP Application ID>",
    apiKey: "<GBP API Key>",
    site: <Site>,
    environment: <Environment>,
    httpClientProvider: .createNew
)

let smp = SMP(client: client)

func marketPrices() async throws -> MarketDetails {
    let request = MarketPricesRequest(marketID: "501.43595890")

    let result = try await smp.marketPrices(request)
}
```
