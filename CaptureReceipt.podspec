Pod::Spec.new do |s|
  s.name             = 'CaptureReceipt'
  s.version          = '0.2.0'
  s.summary          = 'Easily integrate data extraction from receipts, manage data property and licensing, and seamlessly publish data to the TIKI platform.'
  
  s.description      = <<-DESC
  The TIKI Capture Receipt SDK for iOS empowers users to capture and license their purchase data from various sources, including scanning physical receipts, scraping email accounts, and connecting online retailer accounts. All data collected is considered zero-party data, making it legally owned by end-users and licensed to businesses in exchange for fair compensation.

  With this SDK, companies can easily integrate data extraction from receipts, manage data property and licensing, and seamlessly publish data to the TIKI platform.
  
  Receipt parsing is handled on-device, ensuring security, privacy, and compliance with App Store regulations. This process is facilitated by the closed-source, licensed SDK [Microblink](https://microblink.com). For new customers, we offer a **free Microblink license**. Schedule a meeting at [mytiki.com](https://mytiki.com) to acquire a license key.
  
  Raw receipt data is securely stored in a hosted [Iceberg](http://iceberg.apache.org) cleanroom, allowing you to query, ETL (Extract, Transform, Load), and train models against it. A sample cleanroom can be found in our [purchase repository](https://github.com/tiki/purchase).
                       DESC

  s.homepage         = 'https://mytiki.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'TIKI Team' => 'hello@mytiki.com' }
  s.source           = { :git => 'https://github.com/tiki/capture-receipt-ios.git', :tag => s.version.to_s }
  s.ios.deployment_target = '15.0'
  s.source_files = 'CaptureReceipt/Classes/**/*'
  s.dependency 'TikiSdkDebug', '3.0.0', :configurations => 'Debug'
  s.dependency 'TikiSdkRelease', '3.0.0', :configurations => 'Release'
end
