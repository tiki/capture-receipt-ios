/*
 * Account Class
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */


import Foundation
import BlinkReceipt
import BlinkEReceipt

/// A Swift class representing an account, which can be of different types, such as email or retailer.
public class Account {
    /// The username associated with the account.
    let username: String
    /// The type of the account, such as email or retailer, represented by an AccountType object.
    let provider: AccountType
    /// A flag indicating whether the account has been verified (optional).
    var isVerified: Bool?
    
    /// Initializes an Account object with the specified properties.
    ///
    /// - Parameters:
    ///   - accountType: An AccountType object representing the type and source of the account.
    ///   - user: The username associated with the account.
    ///   - isVerified: A flag indicating whether the account has been verified (optional).
    init(accountType: AccountType, user: String, isVerified: Bool?) {
        self.provider = accountType
        self.username = user
        self.isVerified = isVerified ?? false
    }
    
    public static func fromEmailBrAccount(brEmailAccount: BREmailAccount) -> EmailEnum{
        switch (brEmailAccount.provider) {
        case .none:
            break
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
        return .NONE
    }
}
