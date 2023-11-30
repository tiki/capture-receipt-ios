/*
 * RspPaymentMethod Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing payment method information.

 This struct is used to convey payment method details, such as payment method type, card type, card issuer, and amount.
 */
public struct JSPaymentMethod: Encodable {
    /// The payment method, if available.
    private let paymentMethod: JSStringType?
    /// The card type, if available.
    private let cardType: JSStringType?
    /// The card issuer, if available.
    private let cardIssuer: JSStringType?
    /// The payment amount, if available.
    private let amount: JSFloatType?
    
    /**
     Initializes an `RspPaymentMethod` struct.

     - Parameters:
        - paymentMethod: The payment method, if available.
        - cardType: The card type, if available.
        - cardIssuer: The card issuer, if available.
        - amount: The payment amount, if available.
     */
    init(method: BRPaymentMethod) {
        self.paymentMethod = (JSStringType.opt(stringType: method.method) != nil) ? JSStringType.opt(stringType: method.method) : JSStringType(string: "")
        self.cardType = (JSStringType.opt(stringType: method.cardType) != nil) ? JSStringType.opt(stringType: method.cardType) : JSStringType(string: "")
        self.cardIssuer = (JSStringType.opt(stringType: method.cardIssuer) != nil) ? JSStringType.opt(stringType: method.cardIssuer) : JSStringType(string: "")
        self.amount = (JSFloatType.opt(floatType: method.amount) != nil) ? JSFloatType.opt(floatType: method.amount) : JSFloatType(float: 0)
    }
    
    static func opt(method: BRPaymentMethod?) -> JSPaymentMethod? {
        return method != nil ? JSPaymentMethod(method: method!) : nil
    }
    
}
