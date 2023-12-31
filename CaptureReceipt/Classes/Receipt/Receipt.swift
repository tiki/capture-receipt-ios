/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import BlinkReceipt

/**
 A class representing a response containing receipt information for the ReceiptCapture plugin.
 
 This class encapsulates detailed information about a receipt, including various receipt fields such as date, time, products, coupons, totals, and more.
 */
public class Receipt: Encodable{
    /// The date of the receipt, if available.
    private let receiptDate: JSStringType?
    /// The time of the receipt, if available.
    private let receiptTime: JSStringType?
    private let receiptDateTime: Int64?
    /// The retailer's identifier.
    private let retailerId: JSRetailer
    /// An array of products associated with the receipt.
    private let products: [JSProduct]
    /// An array of coupons associated with the receipt.
    private let coupons: [JSCoupon]
    /// The total amount of the receipt, if available.
    private let total: JSFloatType?
    /// The tip amount, if available.
    private let tip: JSFloatType?
    /// The subtotal amount, if available.
    private let subtotal: JSFloatType?
    /// The taxes amount, if available.
    private let taxes: JSFloatType?
    /// The store number, if available.
    private let storeNumber: JSStringType?
    /// The merchant name, if available.
    private let merchantName: JSStringType?
    /// The store address, if available.
    private let storeAddress: JSStringType?
    /// The store city, if available.
    private let storeCity: JSStringType?
    /// The unique identifier for the receipt.
    private let blinkReceiptId: String?
    /// The store state, if available.
    private let storeState: JSStringType?
    /// The store zip code, if available.
    private let storeZip: JSStringType?
//    private let storeZipCountry: JSStringType?
    /// The store phone number, if available.
    private let storePhone: JSStringType?
    /// The cashier's identifier, if available.
    private let cashierId: JSStringType?
    /// The transaction identifier, if available.
    private let transactionId: JSStringType?
    /// The register identifier, if available.
    private let registerId: JSStringType?
    /// An array of payment methods used for the receipt.
    private let paymentMethods: [JSPaymentMethod]
    /// The tax identifier, if available.
    private let taxId: JSStringType?
    /// The mall name, if available.
    private let mallName: JSStringType?
    /// The last four digits of the credit card, if available.
    private let last4cc: JSStringType?
    /// The OCR (Optical Character Recognition) confidence level, if available.
    private let ocrConfidence: Float
    /// Indicates if the top edge of the receipt was found during processing.
    private let foundTopEdge: Bool?
    /// Indicates if the bottom edge of the receipt was found during processing.
    private let foundBottomEdge: Bool?
    /// The eReceipt order number, if available.
    private let eReceiptOrderNumber: String?
    /// The eReceipt order status, if available.
    private let eReceiptOrderStatus: String?
    /// The raw HTML content of the eReceipt, if available.
    private let eReceiptRawHtml: String?
    /// An array of shipment information associated with the receipt.
    private let shipments: [JSShipment]
    /// The long transaction identifier, if available.
    private let longTransactionId: JSStringType?
    /// Indicates if the subtotal matches expectations.
    private let subtotalMatches: Bool?
    /// The email provider associated with the eReceipt, if available.
    private let eReceiptEmailProvider: String?
    /// Indicates if the eReceipt was successfully authenticated.
    private let eReceiptAuthenticated: Bool?
    /// Indicates if the shopper is an Instacart shopper.
    private let instacartShopper: Bool?
    /// Indicates if the receipt is an eReceipt.
    private let eReceipt: Bool
    /// An array of component emails associated with the eReceipt.
    private let eReceiptComponentEmails: [Receipt]
    /// Indicates if the receipt is a duplicate.
    private let duplicate: Bool?
    /// Indicates if the receipt is fraudulent.
    private let fraudulent: Bool?
    /// An array of duplicate BlinkReceipt IDs.
    private let duplicateBlinkReceiptIds: [String]
    /// A guess at the merchant's name.
    private let merchantMatchGuess: String?
    /// The number of products pending lookup.
    private let productsPendingLookup: Int
    /// An array of qualified promotions associated with the receipt.
    private let qualifiedPromotions: [JSPromotion]
    /// An array of unqualified promotions associated with the receipt.
    private let unqualifiedPromotions: [JSPromotion]
    /// Extended fields of the receipt, if available.
//    private let extendedFields: [AnyHashable: Any]?
    /// Additional fees associated with the eReceipt, if available.
    private let eReceiptAdditionalFees: [String: String]?
    /// The purchase type, if available.
    private let purchaseType: JSStringType?
    /// The channel, if available.
    private let channel: JSStringType?
    private let loyaltyForBanner: Bool?
    /// The entity that fulfilled the eReceipt, if available.
    private let eReceiptFulfilledBy: String?
    /// The shipping status of the eReceipt.
    private let eReceiptPOSSystem: String?
    /// The sub-merchant associated with the eReceipt, if available.
    private let eReceiptSubMerchant: String?
    /// An array of qualified surveys associated with the receipt.
    private let qualifiedSurveys: [JSSurvey]
    /// The barcode associated with the receipt, if available.
    private let barcode: String?
    /// The email address of the merchant, if available.
    private let eReceiptMerchantEmail: String?
    /// The subject of the eReceipt email, if available.
    private let eReceiptEmailSubject: String?
    /// The shipping costs associated with the eReceipt, if available.
    private let eReceiptShippingCosts: Float
    /// The currency code, if available.
    private let currencyCode: String?
    /// The client's merchant name, if available.
    private let clientMerchantName: String?
    /// Indicates if the receipt is part of a loyalty program.
    private let loyaltyProgram: Bool?
    /// An array of merchant sources associated with the receipt.
    private let merchantSources: [Int64]
    /// The payment terminal identifier, if available.
    private let paymentTerminalId: JSStringType?
    /// The payment transaction identifier, if available.
    private let paymentTransactionId: JSStringType?
    /// The combined raw text of the receipt, if available.
    private let combinedRawText: JSStringType?

    /**
     Initializes an `RspReceipt` struct.

     - Parameters:
        - scanResults: The `BRScanResults` object containing receipt information.
     */
    init(scanResults: BRScanResults) {
        receiptDate = JSStringType.opt(stringType: scanResults.receiptDate)
        receiptTime = JSStringType.opt(stringType: scanResults.receiptTime)
        receiptDateTime = 0
        retailerId = JSRetailer(retailer: scanResults.retailerId)
        products = scanResults.products?.map { product in JSProduct(product: product) } ?? []
        coupons = scanResults.coupons?.map { coupon in JSCoupon(coupon: coupon) } ?? []
        total = JSFloatType.opt(floatType: scanResults.total)
        tip = JSFloatType.opt(floatType: scanResults.tip)
        subtotal = JSFloatType.opt(floatType: scanResults.subtotal)
        taxes = JSFloatType.opt(floatType: scanResults.taxes)
        storeNumber = JSStringType.opt(stringType: scanResults.storeNumber)
        merchantName = JSStringType.opt(stringType: scanResults.merchantName)
        storeAddress = JSStringType.opt(stringType: scanResults.storeAddress)
        storeCity = JSStringType.opt(stringType: scanResults.storeCity)
        blinkReceiptId = scanResults.blinkReceiptId
        storeState = JSStringType.opt(stringType: scanResults.storeState)
        storeZip = JSStringType.opt(stringType: scanResults.storeZip)
//        storeZipCountry = scanResults.storeZipCountry
        storePhone = JSStringType.opt(stringType: scanResults.storePhone)
        cashierId = JSStringType.opt(stringType: scanResults.cashierId)
        transactionId = JSStringType.opt(stringType: scanResults.transactionId)
        registerId = JSStringType.opt(stringType: scanResults.registerId)
        paymentMethods = scanResults.paymentMethods?.map { payment in JSPaymentMethod(method: payment)} ?? []
        taxId = JSStringType.opt(stringType: scanResults.taxId)
        mallName = JSStringType.opt(stringType: scanResults.mallName)
        last4cc = JSStringType.opt(stringType: scanResults.last4CC)
        ocrConfidence = scanResults.ocrConfidence
        foundTopEdge = scanResults.foundTopEdge
        foundBottomEdge = scanResults.foundBottomEdge
        eReceiptOrderNumber = scanResults.ereceiptOrderNumber
        eReceiptOrderStatus = scanResults.ereceiptOrderStatus
        eReceiptRawHtml = scanResults.ereceiptRawHTML
        shipments = scanResults.shipments?.map { shipment in JSShipment(shipment: shipment) } ?? []
        longTransactionId = JSStringType.opt(stringType: scanResults.longTransactionId)
        subtotalMatches = scanResults.subtotalMatches
        eReceiptEmailProvider = scanResults.ereceiptEmailProvider
        eReceiptAuthenticated = scanResults.ereceiptAuthenticated
        instacartShopper = scanResults.isInstacartShopper
        eReceipt = scanResults.ereceiptIsValid
        eReceiptComponentEmails = scanResults.ereceiptComponentEmails?.map{ res in Receipt(scanResults: res)} ?? []
        duplicate = scanResults.isDuplicate
        fraudulent = scanResults.isFraudulent
        duplicateBlinkReceiptIds = scanResults.duplicateBlinkReceiptIds ?? []
        merchantMatchGuess = scanResults.merchantGuess
        productsPendingLookup = scanResults.productsPendingLookup
        qualifiedPromotions = scanResults.qualifiedPromotions?.map { promotion in JSPromotion(promotion: promotion) } ?? []
        unqualifiedPromotions = scanResults.unqualifiedPromotions?.map { promotion in JSPromotion(promotion: promotion) } ?? []
//        extendedFields = scanResults.extendedFields
        eReceiptAdditionalFees = scanResults.ereceiptAdditionalFees
        purchaseType = JSStringType.opt(string: scanResults.purchaseType)
        channel = JSStringType.opt(stringType: scanResults.channel)
        loyaltyForBanner = false
        eReceiptFulfilledBy = scanResults.ereceiptFulfilledBy
        eReceiptPOSSystem = scanResults.ereceiptPOSSystem
        eReceiptSubMerchant = scanResults.ereceiptSubMerchant
        qualifiedSurveys = scanResults.qualifiedSurveys?.map{survey in JSSurvey(survey: survey)} ?? []
        barcode = scanResults.barcode
        eReceiptMerchantEmail = scanResults.ereceiptMerchantEmail
        eReceiptEmailSubject = scanResults.ereceiptEmailSubject
        eReceiptShippingCosts = scanResults.ereceiptShippingCosts
        currencyCode = scanResults.currencyCode
        clientMerchantName = scanResults.clientMerchantName?.value ?? ""
        loyaltyProgram = scanResults.loyaltyProgram
        merchantSources = scanResults.merchantSources?.map{merchantSources in Int64(truncating: merchantSources)} ?? [0]
        paymentTerminalId = JSStringType.opt(stringType: scanResults.paymentTerminalId)
        paymentTransactionId = JSStringType.opt(stringType: scanResults.paymentTransactionId)
        combinedRawText = JSStringType.opt(string: scanResults.combinedRawText)
    }


}
