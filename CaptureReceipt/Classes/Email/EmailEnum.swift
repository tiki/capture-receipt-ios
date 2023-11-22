/*
 * EmailEnum Enum
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/// An enumeration representing different email providers.
public enum EmailEnum: String, CaseIterable {
    
    /// Represents the Gmail email provider.
    case GMAIL

    /// Represents the AOL email provider.
    case AOL
    
    /// Represents the Yahoo email provider.
    case YAHOO
    
    /// Represents the Outlook email provider.
    case OUTLOOK
    
    /// Represents no email provider.
    case NONE
    
    /// Represents a custom email provider
    case CUSTOM

    /// Converts an EmailEnum case to the corresponding BREReceiptProvider.
    ///
    /// - Returns: A BREReceiptProvider corresponding to the EmailEnum case, or nil if not found.
    func toBREReceiptProvider() -> BREReceiptProvider {
        switch self{
            case .AOL : return .AOL
            case .GMAIL : return .gmailIMAP
            case .OUTLOOK : return .outlook
            case .YAHOO : return .yahoo
            case .NONE: return .none
            case .CUSTOM: return .customIMAP
        }
    }
    
    /// Converts an EmailEnum case to the corresponding BREReceiptProvider.
    ///
    /// - Returns: A BREReceiptProvider corresponding to the EmailEnum case, or nil if not found.
    static func fromBREReceiptProvider(provider: BREReceiptProvider) -> EmailEnum {
        switch (provider){
        case .none:
            return .NONE
        case .gmail:
            return .GMAIL
        case .outlook:
            return .OUTLOOK
        case .yahoo:
            return .YAHOO
        case .AOL:
            return .AOL
        case .gmailIMAP:
            return .GMAIL
        case .customIMAP:
            return .CUSTOM
        case .yahooV2:
            return .YAHOO
        }
    }
}
