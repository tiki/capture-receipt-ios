/*
 *
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation

public class CaptureReceiptBuilder {
    private var _userID: String?
    
    /// The Provider ID.
    private var _providerID: String?
    
    /// The terms associated with the license.
    private var _terms: String?
    
    /// The optional API key for Gmail integration.
    private var _gmailKey: String? = nil
    
    /// The optional API key for Outlook integration.
    private var _outlookKey: String? = nil
    
    
    
    
    
    public func userID(userID: String) -> CaptureReceiptBuilder{
        _userID = userID
        return self
    }
    public func providerID(providerID: String) -> CaptureReceiptBuilder {
        _providerID = providerID
        return self
    }
    public func terms(terms: String) -> CaptureReceiptBuilder {
        _terms = terms
        return self
    }
    public func gmailKey(gmailKey: String) -> CaptureReceiptBuilder {
        _gmailKey = gmailKey
        return self
    }
    public func outlookKey(outlookKey: String) -> CaptureReceiptBuilder {
        _outlookKey = outlookKey
        return self
    }
    
    public func initialize() async throws{
        try await CaptureReceipt.initialize(userId: _userID!, providerID: _providerID!, terms: _terms!, gmailAPIKey: _gmailKey,outlookAPIKey: _outlookKey)
    }
}
