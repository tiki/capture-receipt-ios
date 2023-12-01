/*
 * RspStringType Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing retailer identification information

 This struct is used to convey a retailer id value along with its banner id.
 */
struct JSRetailer: Encodable{
    /// The retailer's id
    private let id: Int
    private var bannerId: Int? = nil
    /**
     Initializes an `JSStringType` struct.

     - Parameters:
        - retailer: The retailer value.
     */
    init(retailer: WFRetailerId) {
        id = Int(retailer.rawValue)
        bannerId = Int(retailer.rawValue)
    }
    
    static func opt(retailer: WFRetailerId?) -> JSRetailer? {
        return retailer != nil ? JSRetailer(retailer: retailer!) : nil
    }

}
