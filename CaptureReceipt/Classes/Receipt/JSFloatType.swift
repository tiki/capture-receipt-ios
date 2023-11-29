/*
 * RspFloatType Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing floating-point values with confidence scores for the ReceiptCapture plugin.

 This struct is used to encapsulate floating-point values along with their confidence scores in response to plugin calls.
 */
struct JSFloatType: Encodable{
    /// The confidence score associated with the value.
    private let confidence: Float?
    
    /// The floating-point value.
    private let value: Float

    /**
     Initializes an `RspFloatType` struct based on a `BRFloatValue` object.

     - Parameter floatType: A `BRFloatValue` object containing the floating-point value and its confidence score.
     */
    init(floatType: BRFloatValue) {
        confidence = floatType.confidence
        value = floatType.value
    }
    
    init (float: Float) {
        value = float
        confidence = nil
    }
    
    static func opt(floatType: BRFloatValue?) -> JSFloatType? {
        return floatType != nil ? JSFloatType(floatType: floatType!) : nil
    }
    
    static func opt(float: Float?) -> JSFloatType? {
        return float != nil ? JSFloatType(float: float!) : nil
    }
}
