# Capture Receipt SDK - iOS

## Introduction

The TIKI Capture Receipt SDK for iOS empowers users to capture and license their purchase data from various sources, including scanning physical receipts, scraping email accounts, and connecting online retailer accounts. All data collected is considered zero-party data, making it legally owned by end-users and licensed to businesses in exchange for fair compensation.

With this SDK, companies can easily integrate data extraction from receipts, manage data property and licensing, and seamlessly publish data to the TIKI platform.

Receipt parsing is handled on-device, ensuring security, privacy, and compliance with App Store regulations. This process is facilitated by the closed-source, licensed SDK [Microblink](https://microblink.com). For new customers, we offer a **free Microblink license**. Schedule a meeting at [mytiki.com](https://mytiki.com) to acquire a license key.

Raw receipt data is securely stored in a hosted [Iceberg](http://iceberg.apache.org) cleanroom, allowing you to query, ETL (Extract, Transform, Load), and train models against it. A sample cleanroom can be found in our [purchase repository](https://github.com/tiki/purchase).

## Features

### 1. Get Purchase Data from Physical and Digital Receipts

Capture Receipt seamlessly integrates with the [Microblink](https://microblink.com/) platform to extract data from both physical and digital receipts. This versatile feature ensures that you can collect information from a wide variety of sources.

### 2. Handle Data Licensing and Compensation with TIKI

Leverage TIKI to efficiently manage data licensing and compensation. Utilize TIKI's data infrastructure to set up licensing agreements, define terms, and ensure fair compensation for your users.

### 3. Publish Data to TIKI

Once users have captured and licensed their data, it is seamlessly published to the TIKI platform. This feature streamlines the process of making the data accessible to a wider audience and facilitates data monetization.

## Getting Started

### Prerequisites

Before getting started, ensure your iOS project meets the following requirements:

- Deployment target version should be iOS 15.0 or later.
- Swift 5.5 or later.
- Cocoapods

### 1. Add Microblink source in the top of your `Podfile`

```
source 'https://github.com/BlinkReceipt/PodSpecRepo.git'
source 'https://cdn.cocoapods.org/'
```

### 2. Add the project dependencies

```
target <YOUR TARGET> do
  use_frameworks!

  # ... other dependencies

  pod 'BlinkReceipt', '~> 1.27'
  pod 'BlinkEReceipt', '~> 2.0'  
  pod 'TikiSdkDebug', '3.0.0', :configurations => 'Debug'
  pod 'TikiSdkRelease', '3.0.0', :configurations => 'Release'

end
```

### 2. Initialize the SDK

During SDK initialization, Capture Receipt initializes the TIKI and Microblink SDKs and creates a License Record for the data provided by users. You need to provide the company's information and the API keys for TIKI and Microblink. Here's how you can initialize the SDK:

```swift
let config = Configuration(
    company: Company(
        name: "Company Inc.",
        location: "Tennessee, USA",
        privacyPolicyURL: URL(string: "https://your-co.com/privacy"),
        termsOfServiceURL: URL(string: "https://your-co.com/terms")
    ),
    key: Key(
        tikiPublishingID: "YOUR TIKI PUBLISHING ID",
        microblinkLicenseKey: "YOUR MICROBLINK LICENSE KEY",
        productIntelligenceKey: "YOUR MICROBLINK PRODUCT INTELLIGENCE KEY"
    )
)

CaptureReceipt.initialize(
    userID: "YOUR USER ID",
    configuration: config
)
```

Now, users can provide their receipt data, and the SDK will handle the licensing and publishing of it.

### Initialize Gmail and/or Outlook APIs

Capture Receipt utilizes IMAP for email scraping as the default method. For an enhanced user experience and improved accuracy, we recommend considering the use of the [Gmail API](https://developers.google.com/gmail/api) and [Outlook API](https://docs.microsoft.com/en-us/outlook/rest/overview) for email scraping. The utilization of these APIs is optional, and you have the flexibility to choose either one, or both.

```swift
let emailConfig = EmailConfiguration(
    gmailAPIKey: "YOUR GMAIL API KEY",
    outlookAPIKey: "YOUR OUTLOOK API KEY"
)

CaptureReceipt.initialize(
    userID: "YOUR USER ID",
    configuration: config,
    emailConfiguration: emailConfig
)
```

## SDK Usage

### Scanning a Physical Receipt
The scan function initiates the process of scanning a physical receipt using the device's camera. It is designed to make capture receipt an efficient and straightforward task within your iOS application. Here's how the function works:

1. The SDK opens the device's camera for the user.
2. The user can take a picture of the physical receipt using the camera.
3. The captured image is processed locally on the user's device, utilizing the Microblink SDK to extract the receipt data.
4. The TIKI SDK adds the license to the receipt data and publishes it to the TIKI platform.
5. The function returns a Receipt object containing the details of the scanned receipt.

```swift
CaptureReceipt.scan(
    onReceipt: { receipt in
        // Process the retrieved receipt data
        print("Receipt Data: \(receipt)")
    },
    onError: { error in
        // Handle errors during the scanning process
        print("Error: \(error)")
    },
    onComplete: {
        // Perform actions upon completion of the scan process
        print("Scan process completed")
    }
)
```

### Add an Email or Retailer Account

Before scraping emails for receipts or grabbing orders from retailer accounts, users need to log in to their accounts. This process varies from one retailer or email provider to another, including 2FA, app passwords, and OAuth authentication. However, all this complexity is handled internally by our SDK. You need to call `CaptureReceipt.login` method with two callbacks for success and error. If the login succeeds, it will call the success callback, passing the Account. If it fails, it will return the error callback with the error.

```swift
CaptureReceipt.login(
    username: "USERNAME FOR LOGIN",
    password: "PASSWORD FOR LOGIN",
    accountType: .gmail, // An enum that identifies the possible accounts
    onAccount: { account in
        print(account)
    },
    onError: { error in
        print(error)
    }
)
```

### List Connected Accounts

```swift
CaptureReceipt.accounts()
```

### Remove Accounts

```swift
CaptureReceipt.logout(
    username: "USERNAME FOR LOGIN",
    accountType: .gmail, // An enum that identifies the possible accounts
    onAccount: { account in
        print(account)
    },
    onError: { error in
        print(error)
    }
)
```

Don't worry; license records issued are backed up to TIKI's immutable, hosted storage for free. After the user logs back in, call `.initialize`, and the SDK will rebuild their license history for you.

### Get Digital Receipt Data

#### One Account

```swift
let account = CaptureReceipt.account(username: "ACCOUNT USERNAME", accountType: .gmail)

CaptureReceipt.receipts(
    account: account,
    onReceipt: { receipt in
        print("Receipt Data: \(receipt)")
    },
    onError: { error in
        print(error)
    },
    onComplete: {
        print("Get receipts for \(account.username) completed")
    }
)
```

#### All Email or All Retailer Accounts

```swift
CaptureReceipt.receipts(
    accountType: .email, // or .retailer
    onReceipt: { receipt in
        print("Receipt Data: \(receipt)")
    },
    onError: { error in
        print(error)
    },
    onComplete: {
        print("Email scraping for all accounts completed")
    }
)
```

#### All Connected Accounts

```swift
CaptureReceipt.receipts(
    onReceipt: { receipt in
        print("Receipt Data: \(receipt)")
    },
    onError: { error in
        print(error)
    },
    onComplete: {
        print("Email scraping for all accounts completed")
    }
)
```

## Example

While this README is helpful, it's always easier to see it in action. In the `/Example` directory, there is a simple demo app. On launch, it generates a new random user id, with a button called "Start."

[This example app is available on the App Store]()

## Open Issues

You can find active issues here on GitHub under [Issues](). If you run into a bug or have a question, just create a new Issue or reach out to a team member on [Discord](https://discord.gg/tiki).

# Contributing

- Use [GitHub Issues](https://github.com/tiki/tiki-receipt-capacitor/issues) to report any bugs you find or to request enhancements.
- If you'd like to get in touch with our team or other active contributors, join our [Discord](https://discord.gg/tiki) server.
- Please use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/) if you intend to add code to this project.