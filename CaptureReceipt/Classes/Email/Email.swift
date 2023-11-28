/*
 * Email Class
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import BlinkReceipt
import BlinkEReceipt

/// A Swift class representing an email plugin for handling e-receipts and email account management.
public class Email {

   let defaults = UserDefaults.standard
    
    /// Initializes the Email plugin with license and product keys.
    ///
    /// - Parameters:
    ///   - licenseKey: The license key for the plugin.
    ///   - productKey: The product key for the plugin.
    ///   - googleClientId: The Google Client ID for OAuth authentication (optional).
    ///   - outlookClientId: The Outlook Client ID for OAuth authentication (optional).
        public init(_ licenseKey: String, _ productKey: String, _ googleClientId: String? = nil,  _ outlookClientId: String? = nil)  {
            DispatchQueue.main.async {
                BRScanManager.shared().licenseKey = licenseKey
                BRScanManager.shared().prodIntelKey = productKey
                if(googleClientId != nil){
                    BREReceiptManager.shared().googleClientId = googleClientId
                }
                if(outlookClientId != nil){
                    BREReceiptManager.shared().outlookClientId = outlookClientId
                }
                BRAccountLinkingManager.shared()
            }
            
        }
    
    /// Logs in a user account using the provided credentials or initiates OAuth authentication for Gmail.
    ///
    /// - Parameters:
    ///   - account: An instance of the Account class containing user and account information.
    ///   - onError: A closure to handle error messages.
    ///   - onSuccess: A closure to handle success actions.
    public func login(username: String, password: String, provider: EmailEnum, onError: @escaping (String) -> Void, onSuccess: @escaping (Account) -> Void) {
        let email = BRIMAPAccount(provider: provider.toBREReceiptProvider(), email: username, password: password)
        DispatchQueue.main.async {
            let rootVc = UIApplication.shared.windows.first?.rootViewController
            BREReceiptManager.shared().setupIMAP(for: email, viewController: rootVc!, withCompletion: { result in
                BREReceiptManager.shared().verifyImapAccount(email, withCompletion: { success, error in
                    guard let receivedError: Int = (error as? NSError)?.code else {
                        if success {
                            onSuccess(Account(accountType: .email(provider) , user: username, isVerified: true))
                            return
                        } else {
                            onError(error.debugDescription)
                            return
                        }
                    }
                    if(receivedError == BREReceiptIMAPError.gmailIMAPDisabled.rawValue){
                        BREReceiptManager.shared().signOut(from: email) { errorLogout in
                            onError("Please, activate the Gmail IMAP")
                        }
                    }else{
                        onError(error.debugDescription)
                    }
                })
            })
        }

    }
    
    /// Logs out a user account or signs out of all accounts.
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onComplete: A closure to handle completion actions.
    ///   - account: An optional instance of the Account struct containing user and account information.
    public func logout(onError: @escaping (String) -> Void, onComplete: @escaping () -> Void, account: String? = nil){
        if(account != nil){
            let linkedAccounts = BREReceiptManager.shared().getLinkedAccounts()
            if(linkedAccounts != nil && !linkedAccounts!.isEmpty){
                let email = linkedAccounts!.first(where: { acc in acc.email == account })
                BREReceiptManager.shared().signOut(from: email) { error in
                    if(error != nil){
                        onError(error.debugDescription)
                    }else{
                        onComplete()
                    }
                }
            }
        }else{
            BREReceiptManager.shared().signOut(completion: { error in
                BREReceiptManager.shared().resetEmailsChecked()
                self.defaults.set(Date.distantPast, forKey: "lastIMAPScan")
                onComplete()
            })
        }
    }
    
    /// Retrieves e-receipts for a user email account
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onReceipt: A closure to handle individual receipt results.
    ///   - onComplete: A closure to handle completion actions.
    public func scan(onError: @escaping (String) -> Void, onReceipt: @escaping (BRScanResults) -> Void, onComplete: @escaping () -> Void) {
        BREReceiptManager.shared().dayCutoff = getDayCutOff()
        Task(priority: .high){
            BREReceiptManager.shared().getEReceipts() {scanResults, emailAccount, error in
                guard let receivedError = error as? BREReceiptIMAPError else {
                    if(scanResults != nil){
                        scanResults!.forEach{scanResults in
                            onReceipt(scanResults)
                        }
                    }
                    self.defaults.set(Date(), forKey: "lastIMAPScan")
                    onComplete()
                    return
                }
                onError(error.debugDescription)

            } 
        }
    }
    
    /// Retrieves a list of linked email accounts.
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onAccount: A closure to handle individual linked email accounts.
    ///   - onComplete: A closure to handle completion actions.
    public func accounts(onError: (String) -> Void, onAccount: (Account) -> Void,  onComplete: () -> Void) {
        let linkedAccounts = BREReceiptManager.shared().getLinkedAccounts()
        linkedAccounts?.forEach{ brAccount in
            var account = Account(accountType: .email(Account.fromEmailBrAccount(brEmailAccount: brAccount)), user: brAccount.email, isVerified: true)
            onAccount(account)
        }
        onComplete()
    }
    

    private func getDayCutOff() -> Int{
        if (defaults.object(forKey: "lastIMAPScan") != nil) {
            let dayCutOffSaved = defaults.object(forKey: "lastIMAPScan") as! Date
            let timeInterval = dayCutOffSaved.timeIntervalSinceNow
            let difference = Int((timeInterval)) / 86400
            if(difference < 15 && difference >= 0){
                return difference
            }
        }
        return 15
    }
    
}
