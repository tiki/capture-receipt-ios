import TikiSdk

/// The Capture Receipt SDK provides methods to interact with the TIKI Capture Receipt SDK for Android.
public class CaptureReceipt {
    
    private static var tikiSdk: TikiSdk = TikiSdk.instance
    private static var email: Email? = nil
    private static var retailer: Retailer? = nil
    private static var license: LicenseRecord? = nil
    private static var configuration: Configuration? = nil
    
    /// Initializes the Capture Receipt SDK.
    ///
    /// - Parameters:
    ///   - userId: The user's unique identifier.
    ///   - options: Configuration options for the SDK.
    ///
    /// - Throws: An error if the SDK initialization fails.
    ///
    /// - SeeAlso: `Configuration`
    public static func initialize(userId: String, config: Configuration? = nil) async throws {
        var configuration = config
        if(configuration == nil && self.configuration == nil){
            throw NSError()
        } else {
            configuration = self.configuration!
        }
        try await tikiSdk.initialize(id: userId, publishingId: configuration!.tikiPublishingID)
        email = Email(configuration!.microblinkLicenseKey, configuration!.productIntelligenceKey)
        retailer = Retailer(configuration!.microblinkLicenseKey, configuration!.productIntelligenceKey)
        var title = try await tikiSdk.trail.title.get(ptr: userId)
        if(title == nil){
            title = try await tikiSdk.trail.title.create(
                ptr: userId,
                tags: [Tag(tag:TagCommon.PURCHASE_HISTORY)])
        }
        license = try await tikiSdk.trail.license.create(
            titleId: title!.id,
            uses: [Use(usecases: [Usecase(usecase: UsecaseCommon.analytics)], destinations: ["*"])],
            terms: configuration!.terms
        )
    }
    
    /// Configures the Capture Receipt SDK with the necessary parameters.
    ///
    /// - Parameters:
    ///   - tikiPublishingID: The TIKI publishing ID.
    ///   - microblinkLicenseKey: The Microblink license key.
    ///   - productIntelligenceKey: The product intelligence key.
    ///   - terms: The terms associated with the license.
    ///   - gmailAPIKey: The API key for Gmail (optional).
    ///   - outlookAPIKey: The API key for Outlook (optional).
    public static func config(
        tikiPublishingID: String,
        microblinkLicenseKey: String,
        productIntelligenceKey: String,
        terms: String,
        gmailAPIKey: String? = nil,
        outlookAPIKey: String? = nil
    ){
        self.configuration = Configuration(
            tikiPublishingID: tikiPublishingID,
            microblinkLicenseKey: microblinkLicenseKey,
            productIntelligenceKey: productIntelligenceKey,
            terms: terms,
            gmailAPIKey: gmailAPIKey,
            outlookAPIKey: outlookAPIKey
        )
    }

    /// Initiates a scan for a physical receipt.
    ///
    /// - Parameters:
    ///   - onReceipt: A callback executed when a receipt is successfully scanned, providing the scanned Receipt object.
    ///   - onError: A callback executed if there is an error during the scanning process, providing an Error object.
    ///   - onComplete: A callback executed when the scanning process is completed, whether successful or not.
    ///
    /// - SeeAlso: `Receipt`
    /// - SeeAlso: `Error`
    public static func scan(
        onReceipt: @escaping (Receipt) -> Void,
        onError: @escaping (Error) -> Void,
        onComplete: @escaping () -> Void
    ) {}

    /// Log in to an account for receipt data retrieval.
    ///
    /// - Parameters:
    ///   - username: The username for the account.
    ///   - password: The password for the account.
    ///   - accountType: The type of account, e.g., Gmail or Retailer.
    ///   - onSuccess: A callback executed on successful login, providing the account information.
    ///   - onError: A callback executed if there is an error during login, providing an Error object.
    public static func login(
        username: String,
        password: String,
        accountType: AccountCommon,
        onSuccess: @escaping (Account) -> Void,
        onError: @escaping (Error) -> Void
    ) {}

    /// Retrieve a list of connected accounts.
    ///
    /// - Returns: A list of connected accounts.
    public static func accounts() -> [Account] {
        return []
    }

    /// Log out of an account.
    ///
    /// - Parameters:
    ///   - username: The username of the account to log out from.
    ///   - onSuccess: A callback executed on successful logout.
    ///   - onError: A callback executed if there is an error during logout, providing an Error object.
    public static func logout(
        username: String,
        onSuccess: @escaping () -> Void,
        onError: @escaping (Error) -> Void
    ) {}

    /// Retrieve digital receipt data for a specific account type.
    ///
    /// This function allows you to retrieve receipt data from all accounts of an account type, such as email or retailer accounts.
    ///
    /// - Parameters:
    ///   - accountType: The type of account for which to retrieve receipt data.
    ///   - onReceipt: A callback executed for each retrieved receipt, providing the retrieved Receipt object.
    ///   - onError: A callback executed if there is an error during data retrieval, providing an Error object.
    ///   - onComplete: A callback executed when the data retrieval process is completed.
    public static func scrape(
        accountType: AccountCommon,
        onReceipt: @escaping (Receipt) -> Void,
        onError: @escaping (Error) -> Void,
        onComplete: @escaping () -> Void
    ) {}

    /// Retrieve digital receipt data for a specific account.
    ///
    /// This function allows you to retrieve digital receipts associated with a specific account.
    ///
    /// - Parameters:
    ///   - account: The account for which you wish to retrieve receipt data.
    ///   - onReceipt: A callback executed for each retrieved receipt, providing the retrieved Receipt object.
    ///   - onError: A callback executed in case of an error during data retrieval, providing an Error object.
    ///   - onComplete: A callback executed upon the completion of the data retrieval process.
    public static func scrape(
        account: Account,
        onReceipt: @escaping (Receipt) -> Void,
        onError: @escaping (Error) -> Void,
        onComplete: @escaping () -> Void
    ) {}

    /// Retrieve digital receipt data for all connected accounts.
    ///
    /// This function allows you to retrieve digital receipts associated with all of the user's connected accounts.
    ///
    /// - Parameters:
    ///   - onReceipt: A callback executed for each retrieved receipt, providing the retrieved Receipt object.
    ///   - onError: A callback executed in case of an error during data retrieval, providing an Error object.
    ///   - onComplete: A callback executed upon the completion of the data retrieval process.
    public static func scrape(
        onReceipt: @escaping (Receipt) -> Void,
        onError: @escaping (Error) -> Void,
        onComplete: @escaping () -> Void
    ) {}
}
