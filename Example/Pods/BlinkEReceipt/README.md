# BlinkEReceipt Integration Instructions

This is a framework which extends the [BlinkReceipt SDK](https://github.com/BlinkReceipt/blinkreceipt-ios) to enable e-receipt parsing functionality. You must first install the BlinkReceipt framework according to the instructions in that repository.

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like BlinkReceipt in your projects. If you do not have Cocoapods installed, see the [Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html#getting-started).

### Podfile

Here is a sample barebones `Podfile` which imports the BlinkEReceipt pod:

```ruby
#You must include this additional source as the BlinkEReceipt pod is hosted in a private spec repository
source 'https://github.com/BlinkReceipt/PodSpecRepo.git'
source 'https://cdn.cocoapods.org/'

platform :ios, '11.0'

target 'YourTarget' do
  use_frameworks!

  pod 'BlinkEReceipt', '~> 2.0'
end
```

After editing your Podfile, run `pod install` and then make sure to open the `.xcworkspace` file rather than the `.xcodeproj`

## Installation with Carthage

[Carthage](https://github.com/Carthage/Carthage) is a lightweight dependency manager for iOS. If you do not have Carthage installed see the [Quick Start](https://github.com/Carthage/Carthage#quick-start)

### Cartfile
```
binary "https://raw.githubusercontent.com/BlinkReceipt/blinkereceipt-ios/master/BlinkEReceiptStatic.json" ~> 2.0
```

After editing your `Cartfile`, run `carthage update` and then add the frameworks to your project as described in the Quick Start above.

## Standalone Installation

If you do not use a dependency manager:

- Download the latest BlinkEReceipt release from https://github.com/BlinkReceipt/blinkereceipt-ios/releases
- Unzip and drag `BlinkEReceiptStatic.framework`, `AccountLinking.framework` and `MailCore.framework` into your XCode project
- In your target's settings, in the General tab, scroll down to `Frameworks, Libraries, and Embedded Content` and change the `Embed` value for all of these frameworks to `Embed & Sign`

## Duplicate Symbol Warning

The BlinkEReceipt SDK includes a number of 3rd party dependencies, some of which are provided only as static libraries or depend on static libraries. As such it was not practical to prefix the symbols found in these dependencies, so if your app also includes these dependencies, you will likely encounter duplicate symbol errors during linking. These dependencies are:

- [MailCore](https://github.com/MailCore/mailcore2)
- [GoogleSignIn](https://developers.google.com/identity/sign-in/ios/)
- [GTMSessionFetcher](https://github.com/google/gtm-session-fetcher)
- [GTMAppAuth](https://github.com/google/GTMAppAuth)
- [AppAuth](https://github.com/openid/AppAuth-iOS)
- [GoogleAPIClientForREST](https://github.com/google/google-api-objectivec-client-for-rest)

If you need to use these dependencies in your app, you may rely on the BlinkEReceipt SDK to provide the symbols and simply include the appropriate headers in your project for compilation. Be sure to check that the versions imported by the SDK match the headers you are including.

## Integration

Please see our integration instructions and reference at https://blinkreceipt.github.io/blinkereceipt-ios

Copyright (c) 2020 BlinkReceipt. All rights reserved.
