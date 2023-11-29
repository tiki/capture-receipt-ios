/*
 * RspCoupon Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing coupon information for the ReceiptCapture plugin.

 This struct is used to encapsulate coupon details, including its type, amount, SKU, description, and related product index, in response to plugin calls.
 */
struct JSCoupon : Encodable{
    /// The type of the coupon.
    private let type: String?
    
    /// The coupon amount, if available.
    private let amount: JSFloatType?
    
    /// The SKU (Stock Keeping Unit) associated with the coupon, if available.
    private let sku: JSStringType?
    
    /// The description or text associated with the coupon, if available.
    private let description: JSStringType?
    
    /// The index of the related product associated with this coupon.
    private let relatedProductIndex: Int

    /**
     Initializes an `RspCoupon` struct based on a `BRCoupon` object.

     - Parameter coupon: A `BRCoupon` object containing coupon information.
     */
    init(coupon: BRCoupon) {
        type = String(describing: coupon.couponType)
        amount = JSFloatType.opt(floatType: coupon.couponAmount)
        sku = JSStringType.opt(stringType: coupon.couponSku)
        description = JSStringType.opt(string: coupon.description)
        relatedProductIndex = coupon.relatedProductIndex
    }
    
    static func opt(coupon: BRCoupon?) -> JSCoupon? {
        return coupon != nil ? JSCoupon(coupon: coupon!) : nil
    }

}
