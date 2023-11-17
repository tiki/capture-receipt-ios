/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation

/// A structure representing the configuration parameters for the Capture Receipt SDK.
public struct Configuration {
    
    /// The TIKI publishing ID.
    let tikiPublishingID: String
    
    /// The Microblink license key
    let microblinkLicenseKey: String
    
    /// The product intelligence key for data analytics.
    let productIntelligenceKey: String
    
    /// The terms associated with the license.
    let terms: String
    
    /// The optional API key for Gmail integration.
    var gmailAPIKey: String? = nil
    
    /// The optional API key for Outlook integration.
    var outlookAPIKey: String? = nil
}
