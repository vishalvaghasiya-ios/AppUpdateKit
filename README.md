# AppUpdateKit

```swift
.package(url: "https://github.com/vishalvaghasiya-ios/AppUpdateKit.git", from: "1.0.0")
```

# AppUpdateKit

A lightweight Swift package to handle in-app update prompts, version checks, and user-friendly update flows for iOS apps.

## 📚 Table of Contents
- [✨ Features](#-features)
- [🛠 Requirements](#-requirements)
- [📦 Installation](#-installation)
  - [Swift Package Manager (SPM)](#swift-package-manager-spm)
- [🚀 How to Use](#-how-to-use)
- [📝 Version](#-version)
- [⚠️ Notes](#-notes)
- [👤 Author](#-author)
- [📄 License](#-license)

## ✨ Features
- 🔄 Check App Store version programmatically
- 📲 Prompt users with customizable update dialogs
- ⏱ Option for forced or flexible updates
- 🎨 Customizable UI for update alerts
- 🛡 Safe, lightweight, and easy to integrate

## 🛠 Requirements
- iOS 13.0+ 
- Xcode 14+
- Swift 5.7+

## 📦 Installation

### Swift Package Manager (SPM)

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL:
   ```swift
   https://github.com/your-username/AppUpdateKit.git (Version 1.0.0)
   ```
3. Choose the latest release version.
4. Add the dependency to your target.

## 🚀 How to Use

Example:
```swift
import AppUpdateKit

AppUpdateKit.shared.checkForUpdate { result in
    switch result {
    case .updateAvailable(let version):
        print("Update available: \(version)")
        // Show update alert here
    case .upToDate:
        print("App is up to date")
    case .error(let error):
        print("Error checking update: \(error)")
    }
}
```

## 📝 Version
Current Version: **1.0.0 (Initial Release)**

## ⚠️ Notes
- ATT prompt must be configured with `NSUserTrackingUsageDescription` in **Info.plist** if you plan to use tracking with updates.
- The update dialog UI is customizable to fit your app design.

## 👤 Author
- Vishal Vaghasiya  
- 💼 Senior iOS Developer

## 📄 License
AppUpdateKit is available under the MIT license. See the LICENSE file for details.
