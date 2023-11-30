/*
 * RspShipment Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing shipment information.

 This struct is used to convey details about a shipment, including its status and the list of products within the shipment.
 */
struct JSShipment: Encodable {
    /// The status of the shipment.
    private let status: String?
    /// The list of products within the shipment.
    private let products: [JSProduct]

    /**
     Initializes an `RspShipment` struct.

     - Parameters:
        - shipment: The shipment information.
     */
    init(shipment: BRShipment) {
        status = shipment.status
        products = shipment.products?.map { product in JSProduct(product: product) } ?? []
    }
    
    static func opt(shipment: BRShipment?) -> JSShipment? {
        return shipment != nil ? JSShipment(shipment: shipment!) : nil
    }

}
