# URLExpander
> Expande shortened URLs.

## Installation

Add this project on your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/garush13/URLExpander.git", majorVersion: 0, minor: 0)
    ]
)
```

## Usage example


```swift
import URLExpander
let expandedURL = await URLExpander.shared.expand(url: "https://bit.ly/3ASf9fI")
```

## License

Distributed under the MIT license.
