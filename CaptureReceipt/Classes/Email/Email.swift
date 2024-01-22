/*
 * Email Class
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in the root directory.
 */

import Foundation
import AppAuth

/// A Swift class representing an email plugin for handling e-receipts and email account management.
public class Email {
    
    static var currentAuthorizationFlow: OIDExternalUserAgentSession?
    
    let defaults = UserDefaults.standard
    
    private var authState: OIDAuthState?
    public func setAuthState(_ state: OIDAuthState?){
        authState = state
    }
    
    /// Initializes the Email plugin with license and product keys.
    ///
    /// - Parameters:
    ///   - licenseKey: The license key for the plugin.
    ///   - productKey: The product key for the plugin.
    ///   - googleClientId: The Google Client ID for OAuth authentication (optional).
    ///   - outlookClientId: The Outlook Client ID for OAuth authentication (optional).
    public init(_ googleClientId: String? = nil,  _ outlookClientId: String? = nil)  {
        
    }
    
    /// Logs in a user account using the provided credentials or initiates OAuth authentication for Gmail.
    ///
    /// - Parameters:
    ///   - account: An instance of the Account class containing user and account information.
    ///   - onError: A closure to handle error messages.
    ///   - onSuccess: A closure to handle success actions.
    public func login(_ provider:EmailProviderEnum, _ clientID: String, _ clientSecret: String = "") {

        let configuration = OIDServiceConfiguration(
            authorizationEndpoint: provider.authorizationEndpoint(),
            tokenEndpoint: provider.tokenEndpoint())
        let redirectURI = URL(string: "mytiki://app-auth")!
        let viewController = UIApplication.shared.windows.first!.rootViewController!
        let request = OIDAuthorizationRequest(configuration: configuration,
                                              clientId: clientID,
                                              clientSecret: clientSecret,
                                              scopes: [OIDScopeOpenID, OIDScopeProfile],
                                              redirectURL: redirectURI,
                                              responseType: OIDResponseTypeCode,
                                              additionalParameters: nil)

        // performs authentication request
        print("Initiating authorization request with scope: \(request.scope ?? "nil")")

        Email.currentAuthorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: viewController) { authState, error in
          if let authState = authState {
            self.setAuthState(authState)
            print("Got authorization tokens. Access token: " +
                  "\(authState.lastTokenResponse?.accessToken ?? "nil")")
          } else {
            print("Authorization error: \(error?.localizedDescription ?? "Unknown error")")
            self.setAuthState(nil)
          }
        }
        
    }
    
    /// Logs out a user account or signs out of all accounts.
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onComplete: A closure to handle completion actions.
    ///   - account: An optional instance of the Account struct containing user and account information.
    public func logout(onError: @escaping (String) -> Void, onComplete: @escaping () -> Void, account: String? = nil){
        
    }
    
    /// Retrieves e-receipts for a user email account
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onReceipt: A closure to handle individual receipt results.
    ///   - onComplete: A closure to handle completion actions.
    public func scan(onError: @escaping (String) -> Void, onReceipt: @escaping () -> Void, onComplete: @escaping () -> Void) {
        
        
    }
    /// Retrieves e-receipts for an user email account
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onReceipt: A closure to handle individual receipt results.
    ///   - onComplete: A closure to handle completion actions.
    public func scanAccount(onError: @escaping (String) -> Void, onReceipt: @escaping () -> Void, onComplete: @escaping () -> Void) {
        
    }
    
    /// Retrieves a list of linked email accounts.
    ///
    /// - Parameters:
    ///   - onError: A closure to handle error messages.
    ///   - onAccount: A closure to handle individual linked email accounts.
    ///   - onComplete: A closure to handle completion actions.
    public func accounts(onError: (String) -> Void, onAccount: () -> Void,  onComplete: () -> Void) {
        
        onComplete()
    }
    
}
