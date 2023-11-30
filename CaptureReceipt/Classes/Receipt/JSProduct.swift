/*
 * RspProduct Struct
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/**
 Represents a response containing product information.

 This struct is used to convey product details, including product number, description, quantity, pricing, brand, category, and more.
 */
struct JSProduct: Encodable {
    /// The product number, if available.
    private let productNumber: JSStringType?
    /// The product description, if available.
    private let description: JSStringType?
    /// The quantity of the product, if available.
    private let quantity: JSFloatType?
    /// The unit price of the product, if available.
    private let unitPrice: JSFloatType?
    /// The unit of measure for the product, if available.
    private let unitOfMeasure: JSStringType?
    /// The total price of the product, if available.
    private let totalPrice: JSFloatType?
    /// The full price of the product, if available.
    private let fullPrice: JSFloatType?
    private let line: Int32
    /// The product name, if available.
    private let productName: String?
    /// The brand of the product, if available.
    private let brand: String?
    /// The category of the product, if available.
    private let category: String?
    /// The size of the product, if available.
    private let size: String?
    private let rewardsGroup: String?
    private let competitorRewardsGroup: String?
    /// The UPC code for the product
    private let upc: String?
    /// The URL of the product image, if available.
    private let imageUrl: String?
    /// The shipping status of the product, if available.
    private let shippingStatus: String?
    /// Additional lines associated with the product.
    private let additionalLines: [JSAdditionalLine]?
    /// The price of the product after applying coupons, if available.
    private let priceAfterCoupons: JSFloatType?
    /// Indicates if the product is voided.
    private let voided: Bool?
    /// The probability associated with the product.
    private let probability: Float?
    /// Indicates if the product is sensitive.
    private let sensitive: Bool?
    /// Possible sub-products associated with the product.
    private let possibleProducts: [JSProduct]?
    /// Sub-products of the product.
    private let subProducts: [JSProduct]?
    /// Indicates if the product is user-added.
    private let added: Bool?
    /// The brand according to BlinkReceipt.
    private let blinkReceiptBrand: String?
    /// The category according to BlinkReceipt.
    private let blinkReceiptCategory: String?
//    /// A map of extended fields associated with the product.
    private let extendedFields: [String: String]?
    /// The fuel type of the product.
    private let fuelType: String?
    /// The description prefix, if available.
    private let descriptionPrefix: JSStringType?
    /// The description postfix, if available.
    private let descriptionPostfix: JSStringType?
    /// The SKU prefix, if available.
    private let skuPrefix: JSStringType?
    /// The SKU postfix, if available.
    private let skuPostfix: JSStringType?
    private let attributes: [[String: String]]
    /// The sector of the product.
    private let sector: String?
    /// The department of the product.
    private let department: String?
    /// The major category of the product.
    private let majorCategory: String?
    /// The sub-category of the product.
    private let subCategory: String?
    /// The item type of the product.
    private let itemType: String?

    /**
     Initializes an `RspProduct` struct.

     - Parameters:
        - product: The `BRProduct` object containing product information.
     */
    init(product: BRProduct) {
        productNumber = JSStringType.opt(stringType: product.productNumber)
        description = JSStringType.opt(string: product.description)
        quantity = JSFloatType.opt(floatType: product.quantity)
        unitPrice = JSFloatType.opt(floatType: product.unitPrice)
        unitOfMeasure = JSStringType.opt(stringType: product.unitOfMeasure)
        totalPrice = JSFloatType.opt(floatType: product.totalPrice)
        fullPrice = JSFloatType.opt(floatType: product.fullPrice)
        productName = product.productName
        brand = product.brand
        category = product.category
        size = product.size
        upc = product.upc
        imageUrl = product.imgUrl
        shippingStatus = product.shippingStatus
        additionalLines = product.additionalLines?.map { additionalLine in JSAdditionalLine(additionalLine: additionalLine) } ?? []
        priceAfterCoupons = JSFloatType.opt(floatType: product.priceAfterCoupons)
        voided = product.isVoided
        probability = product.probability
        sensitive = product.isSensitive
        possibleProducts = product.possibleProducts?.map { prd in JSProduct(product: prd) } ?? []
        subProducts = product.subProducts?.map { prd in JSProduct(product: prd) } ?? []
        added = product.userAdded
        blinkReceiptBrand = product.brand
        blinkReceiptCategory = product.category
//        extendedFields = product.extendedFields != nil ? {
//            var ret = JSONEncoder()
//            product.extendedFields!.forEach { (key: AnyHashable, value: Any) in
//                ret.updateValue(value as! any JSValue, forKey: key as! String)
//            }
//            return ret
//        }() : nil
        fuelType = product.fuelType
        descriptionPrefix = JSStringType.opt(stringType: product.prodDescPrefix)
        descriptionPostfix = JSStringType.opt(stringType: product.prodDescPostfix)
        skuPrefix = JSStringType.opt(stringType: product.prodNumPrefix)
        skuPostfix = JSStringType.opt(stringType: product.prodNumPostfix)
        sector = product.sector
        department = product.department
        majorCategory = product.majorCategory
        subCategory = product.subCategory
        itemType = product.itemType
    }

    static func opt(product: BRProduct?) -> JSProduct? {
        return product != nil ? JSProduct(product: product!) : nil
    }

}
