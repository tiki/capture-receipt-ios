/*
 *
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import TikiSdk


public class LicenseService {
    private var userId: String?
    private var providerId: String?
    private var terms: String?
    private var expiry: String?
    private static var tikiSdk: TikiSdk = TikiSdk.instance

    
    public func userId(userId: String){
        self.userId = userId
    }
    public func providerId(providerId: String){
        self.providerId = providerId
    }
    public func terms(terms: String){
        self.terms = terms
    }
    public func expiry(expiry: String){
        self.expiry = expiry
    }
    
    /// Initializes the Tiki SDK.
    ///
    /// - Parameters:
    ///   - id: The user's unique identifier.
    ///   - publishingId: The publishing unique identifier.
    ///
    /// - Throws: An error if the SDK initialization fails.
    public static func initialize(id: String, publishingId: String) async throws{
        try await tikiSdk.initialize(id: id, publishingId: publishingId)

    }
    
    /// Create an TikiSdk License.
    ///
    /// - Parameters:
    ///   - userId: The user's unique identifier.
    ///   - providerID: The publishing unique identifier.
    ///   - terms: The terms of use.
    ///   - expiry: The expiration date.
    ///
    /// - Throws: An error if the license create fails.
    public static func license(userId: String?, providerID: String?, terms: String?, expiry: String?) async throws -> LicenseRecord? {
        var title = try await tikiSdk.trail.title.get(ptr: userId ?? "")
        if(title == nil){
            title = try await tikiSdk.trail.title.create(
                ptr: userId ?? "",
                tags: [Tag(tag:TagCommon.PURCHASE_HISTORY)])
        }
        CaptureReceipt.title = title
        var license = try await tikiSdk.trail.license.create(
            titleId: title!.id,
            uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)], destinations: ["*"])],
            terms: terms ?? ""
        )
        
        return license
    }
    
    /// Get an TikiSdk License.
    ///
    /// - Parameters:
    ///   - id: The license unique identifier.
    ///
    /// - Throws: An error if the get license fails.
    public static func license(id: String) async throws -> LicenseRecord? {
        var license = try await tikiSdk.trail.license.get(id: id)
        return license
    }
}
