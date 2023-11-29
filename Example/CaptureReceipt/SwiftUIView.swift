/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import SwiftUI
import CaptureReceipt

@main
struct RewardsExampleApp: App {
    
    @State var isInitialized = false
    @State var startBtnEnabled = true
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some Scene {
        WindowGroup {
            if( !isInitialized ) {
                Button(action: {
                    CaptureReceipt.config(
                        tikiPublishingID: "4a03c7fc-1533-48f4-b0e7-c34e49af91cf",
                        microblinkLicenseKey: "sRwAAAEaY29tLm15dGlraS5jYXB0dXJlLnJlY2VpcHRuGv//0KdCFBQgFSNOuVduGfcqT3S6jLuPoAoP5bngYkX32/19dPBW2zVYisI6sB8SjLy9dgepoVdIs6sCZZPy7uWIcGKfdSGx8vgrEzd/phAThD+5mfJ6DTn/0eDRoFDn1/siDikIwWpsxJSRkjGBQysdOKmlhTtWHUHeNGwvAVrl6T64+Q==",
                        productIntelligenceKey: "wSNX3mu+YGc/2I1DDd0NmrYHS6zS1BQt2geMUH7DDowER43JGeJRUErOHVwU2tz6xHDXia8BuvXQI3j37I0uYw==",
                        terms: "terms for testing")
                    Task{
                        try? await CaptureReceipt.initialize(userId: "testUser123")
                        isInitialized = true
                    }
                }) {
                    HStack (spacing: 5) {
                        Image(systemName: "hand.tap.fill")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                        Text("Click to start")
                            .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }else{
                Text("Scan physical receipt")
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            await CaptureReceipt.scan(
                                onReceipt: { receipt in
                                    print(receipt)
                                },
                                onError: {error in
                                    print(error.localizedDescription)
                                },
                                onComplete: {
                                    print("done!")
                                })
                        }
                    }
                TextField("enter user name", text: $username)
                    .padding(10)
                
                SecureField("enter a password", text: $password)
                    .padding(10)
                Text("Amazon Login")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            CaptureReceipt.login(
                                username: username,
                                password: password,
                                accountType: .retailer(.AMAZON),
                                onSuccess: { account in print("amazon connected") },
                                onError: {error in print("error \(error)") } )
                        }
                    }
                Text("Gmail Login")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            CaptureReceipt.login(
                                username: username,
                                password: password,
                                accountType: .email(.GMAIL),
                                onSuccess: { account in print("gmail connected") },
                                onError: {error in print("error \(error)") } )
                        }
                    }
                Text("Logout Amazon")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            CaptureReceipt.logout(accountType: .retailer(.AMAZON), onSuccess: {print("Logout")},onError: {error in print("error \(error)") })
                        }
                    }
                Text("Logout Gmail")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            CaptureReceipt.logout(accountType: .email(.GMAIL), username: nil, onSuccess: {print("Logout")},onError: {error in print("error \(error)") })
                        }
                    }
                Text("Accounts")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            print(CaptureReceipt.accounts(onSuccess: {print("Accounts")}, onError: {error in print("error \(error)") }))
                        }
                    }
                Text("Scan")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            print("ScanStart")
                            CaptureReceipt.scrape(onReceipt: {receipt in print(receipt)}, onError: {error in print("error \(error)") }, onComplete: {print("Scan")})
                        }
                    }
                Text("Scan Account")
                    .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        Task{
                            print("ScanStart")
                            CaptureReceipt.scrape(account: Account.init(accountType: .email(.GMAIL), user: "jessemonteiroferreira@gmail.com", isVerified: true),onReceipt: {receipt in print(receipt)}, onError: {error in print("error \(error)") }, onComplete: {print("Scan")})
                        }
                    }
            }
            
        }
    }
}

