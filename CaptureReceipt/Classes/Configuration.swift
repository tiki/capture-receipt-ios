/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation

/// A structure representing the configuration parameters for the Capture Receipt SDK.
public struct Configuration {
    
    /// The TIKI publishing ID.
    public let tikiPublishingID: String
    
    /// The Microblink license key
    public let microblinkLicenseKey: String
    
    /// The product intelligence key for data analytics.
    public let productIntelligenceKey: String
    
    /// The terms associated with the license.
    public let terms: String
    
    /// The optional API key for Gmail integration.
    public var gmailAPIKey: String? = nil
    
    /// The optional API key for Outlook integration.
    public var outlookAPIKey: String? = nil
    
    public init(tikiPublishingID: String, microblinkLicenseKey: String, productIntelligenceKey: String, terms: String, gmailAPIKey: String? = nil, outlookAPIKey: String? = nil) {
        self.tikiPublishingID = tikiPublishingID
        self.microblinkLicenseKey = microblinkLicenseKey
        self.productIntelligenceKey = productIntelligenceKey
        self.terms = terms
        self.gmailAPIKey = gmailAPIKey
        self.outlookAPIKey = outlookAPIKey
    }
}
