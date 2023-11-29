/*
 * RspAdditionalLine Class
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing additional line information for a product in the ReceiptCapture plugin.

 This class is used to encapsulate additional line details of a product, including its type, text, and line number in response to plugin calls.
 */
class JSAdditionalLine : Encodable{
    /// The type of the additional line (e.g., "Subtotal").
    private let type: JSStringType?
    
    /// The text content of the additional line.
    private let text: JSStringType?
    
    /// The line number representing the order of the additional line.
    private let lineNumber: Int

    /**
     Initializes an `RspAdditionalLine` instance based on a `BRProductAdditionalLine` object.

     - Parameter additionalLine: A `BRProductAdditionalLine` object containing additional line information.
     */
    init(additionalLine: BRProductAdditionalLine) {
        type = JSStringType.opt(stringType: additionalLine.type)
        text = JSStringType.opt(stringType: additionalLine.text)
        lineNumber = additionalLine.lineNumber
    }
    
    static func opt(additionalLine: BRProductAdditionalLine?) -> JSAdditionalLine? {
        return additionalLine != nil ? JSAdditionalLine(additionalLine: additionalLine!) : nil
    }

}
