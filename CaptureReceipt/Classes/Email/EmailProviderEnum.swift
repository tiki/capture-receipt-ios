import Foundation

public enum EmailProviderEnum{
    
    case GOOGLE
    case OUTLOOK
    
    public func authorizationEndpoint() -> URL{
        switch(self) {
            case .GOOGLE :
                return URL(string: "https://accounts.google.com/o/oauth2/v2/auth")!
            case .OUTLOOK :
                return URL(string: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize")!
            
        }
    }
    
    public func tokenEndpoint() -> URL{
        switch(self) {
            case .GOOGLE :
                return URL(string: "https://www.googleapis.com/oauth2/v4/token")!
            case .OUTLOOK :
                return URL(string: "https://login.microsoftonline.com/common/oauth2/v2.0/token")!
            
        }
    }
            
}
