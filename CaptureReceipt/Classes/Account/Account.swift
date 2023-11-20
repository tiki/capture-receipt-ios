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
    /// The type of the account, such as email or retailer, represented by an AccountType object.
    let accountType: AccountType
    /// The username associated with the account.
    let user: String
    /// A flag indicating whether the account has been verified (optional).
    var isVerified: Bool?
    
    /// Initializes an Account object with the specified properties.
    ///
    /// - Parameters:
    ///   - accountType: An AccountType object representing the type and source of the account.
    ///   - user: The username associated with the account.
    ///   - isVerified: A flag indicating whether the account has been verified (optional).
    init(accountType: AccountType, user: String, password: String?, isVerified: Bool?) {
        self.accountType = accountType
        self.user = user
        self.isVerified = isVerified ?? false
    }
}
