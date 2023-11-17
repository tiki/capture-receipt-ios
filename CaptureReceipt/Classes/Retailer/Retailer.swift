/*
 * Retailer Class
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/// A Swift class representing a retailer plugin for use with
public class Retailer {
    
    /// Initializes the Retailer plugin with license and product keys.
    ///
    /// - Parameters:
    ///   - licenseKey: The license key for the plugin.
    ///   - productKey: The product key for the plugin.
    public init(_ licenseKey: String, _ productKey: String){
        DispatchQueue.main.async{
            BRScanManager.shared().licenseKey = licenseKey
            BRScanManager.shared().prodIntelKey = productKey
            BRAccountLinkingManager.shared()
        }
    }
    /// Logs in a user account with the specified credentials.
    ///
    /// - Parameters:
    ///   - account: An instance of the Account struct containing user and account information.
    ///   - onError: A closure to handle error messages.
    ///   - onSuccess: A closure to handle successful login.
    public func login(_ account: Account, onError: @escaping (String) -> Void, onSuccess: @escaping (Account) -> Void) {
        let dayCutoff: Int = 15
        let username: String = account.user
        guard let retailer: BRAccountLinkingRetailer =
                RetailerEnum(rawValue: account.accountType.source)?.toBRAccountLinkingRetailer() else {
            onError("Unsuported retailer \(account.accountType.source)")
            return
        }
        guard let password: String = account.password else {
            onError("Password is required for login")
            return
        }
        let connection = BRAccountLinkingConnection( retailer: retailer, username: username,
                                                     password: password)
        connection.configuration.dayCutoff = dayCutoff
        connection.configuration.returnLatestOrdersOnly = true
        connection.configuration.countryCode = "US"
        let error = BRAccountLinkingManager.shared().linkRetailer(with: connection)
        if (error == .none) {
            // Success
            DispatchQueue.main.async{
                BRAccountLinkingManager.shared().verifyRetailer(with: connection, withCompletion: {
                    error, viewController, sessionId in
                    self.verifyRetailerCallback(error,viewController, connection, { error in onError(error) }, {account in onSuccess(account)}, account)
                })
            }
        }else {
            onError("Login Error")
        }
    }
    /// Logs out a user account.
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onComplete: A closure to handle the completion of the logout process.
    ///   - account: An instance of the Account struct containing user and account information.
    public func logout(onError: @escaping (String) -> Void, onComplete: @escaping () -> Void, account: Account? = nil) {
        if (account == nil) {
            BRAccountLinkingManager.shared().resetHistory()
            DispatchQueue.main.async {
                BRAccountLinkingManager.shared().unlinkAllAccounts {
                    onComplete()
                }
            }
            return
        }
        
        guard let retailer: BRAccountLinkingRetailer = RetailerEnum( rawValue: account!.accountType.source)?.toBRAccountLinkingRetailer() else {
            onError("Unsuported retailer \(account!.accountType.type)")
            return
        }
        
        BRAccountLinkingManager.shared().resetHistory(for: retailer)
        DispatchQueue.main.async {
            BRAccountLinkingManager.shared().unlinkAccount(for: retailer) {
                onComplete()
            }
        }

    }
    /// Retrieves orders for a specific user account or for all linked accounts.
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onReceipt: A closure to handle individual receipt results.
    ///   - onComplete: A closure to handle the completion of the order retrieval process.
    public func orders(onError: @escaping (String) -> Void, onReceipt: @escaping(BRScanResults) -> Void, onComplete: @escaping () -> Void){
        Task(priority: .high) {
            let retailers = BRAccountLinkingManager.shared().getLinkedRetailers()
            for ret in retailers {
                guard let retailerId = BRAccountLinkingRetailer(rawValue: UInt(truncating: ret)) else{
                    continue
                }
                DispatchQueue.main.async {
                    BRAccountLinkingManager.shared().grabNewOrders( for: retailerId)  { retailer, order, remaining, viewController, errorCode, sessionId in
                        if(errorCode == .none && order != nil){
                            onReceipt(order!)
                            print(order!)
                        }
                        if(remaining == 0){
                            onComplete()
                        }

                    }
                }
                
            }
        }
    }
    

        
        /// Retrieves a list of linked accounts.
        ///
        /// - Parameters:
        ///   - onError: A closure to handle error messages.
        ///   - onAccount: A closure to handle individual linked email accounts.
        ///   - onComplete: A closure to handle the completion of the account retrieval process.
        public func accounts (onError: (String) -> Void, onAccount: (Account) -> Void,  onComplete: () -> Void) {
            let retailers = BRAccountLinkingManager.shared().getLinkedRetailers()
            for ret in retailers {
                let connection =  BRAccountLinkingManager.shared().getLinkedRetailerConnection(BRAccountLinkingRetailer(rawValue: ret.uintValue)!)
                let accountCommon = AccountCommon.init(type: .retailer, source: RetailerEnum.fromBRAccountLinkingRetailer(BRAccountLinkingRetailer(rawValue: ret.uintValue)!).toString()!)
                let account = Account(accountType: accountCommon, user: connection!.username!, password: connection!.password!, isVerified: true)
                onAccount(account)
            }
            onComplete()
            
        }
        /// Handles the callback after attempting to verify a retailer account.
        ///
    /// - Parameters:
    ///   - error: The BRAccountLinkingError code indicating the result of the verification.
    ///   - viewController: The UIViewController to present for verification if needed.
    ///   - connection: The BRAccountLinkingConnection object representing the user's account connection.
    ///   - onError: A closure to handle error messages.
    ///   - onComplete: A closure to handle the completion of the verification process.
    ///   - account: An instance of the Account struct containing user and account information.
        private func verifyRetailerCallback(
            _ error: BRAccountLinkingError,
            _ viewController: UIViewController?,
            _ connection: BRAccountLinkingConnection,
            _ onError: (String) -> Void,
            _ onComplete: (Account) -> Void,
            _ account: Account)
        {
            switch error {
            case .verificationNeeded :
                let rootVc = UIApplication.shared.windows.first?.rootViewController
                rootVc!.present(viewController!, animated: true, completion: nil)
                break
            case .verificationCompleted :
                let rootVc = UIApplication.shared.windows.first?.rootViewController
                rootVc!.dismiss(animated: true)
                break
            case .noCredentials :
                onError("Credentials have not been provided")
                break
            case .internal :
                onError("Unexpected error: internal")
                break
            case .parsingFail :
                onError("General Error: parsing fail")
                break
            case .invalidCredentials :
                onError("Invalid credentials. Please verify provided username and password.")
                break
            case .cancelled :
                viewController?.dismiss(animated: true)
                onError("Account login canceled.")
                break
            default :
                BRAccountLinkingManager.shared().linkRetailer(with: connection)
                account.isVerified = true
                onComplete(account)
                
            }
        }
    }
    

