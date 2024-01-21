import Foundation
import AppAuth

extension UIApplicationDelegate {
   
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
      if let authorizationFlow = Email.currentAuthorizationFlow,
                                 authorizationFlow.resumeExternalUserAgentFlow(with: url) {
        Email.currentAuthorizationFlow = nil
        return true
      }

      return false
    }
}
