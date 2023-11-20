/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import SwiftUI
import CaptureReceipt

@main
struct RewardsExampleApp: App {
    
    @State var isInitialized = false
    
    var body: some Scene {
        WindowGroup {
            if( !isInitialized ) {
                Button(action: {
                    CaptureReceipt.config(
                        tikiPublishingID: "4a03c7fc-1533-48f4-b0e7-c34e49af91cf",
                        microblinkLicenseKey: "sRwAAAEaY29tLm15dGlraS5jYXB0dXJlLnJlY2VpcHRuGv//0KdCFBQgFSNOuVduGfcqT3S6jLuPoAoP5bngYkX32/19dPBW2zVYisI6sB8SjLy9dgepoVdIs6sCZZPy7uWIcGKfdSGx8vgrEzd/phAThD+5mfJ6DTn/0eDRoFDn1/siDikIwWpsxJSRkjGBQysdOKmlhTtWHUHeNGwvAVrl6T64+Q==",
                        productIntelligenceKey: "",
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
                Button(action: {
                    CaptureReceipt.config(
                        tikiPublishingID: "4a03c7fc-1533-48f4-b0e7-c34e49af91cf",
                        microblinkLicenseKey: "sRwAAAAoY29tLm15dGlraS5zZGsuY2FwdHVyZS5yZWNlaXB0LmNhcGFjaXRvcgY6SQlVDCCrMOCc/jLI1A3BmOhqNvtZLzShMcb3/OLQLiqgWjuHuFiqGfg4fnAiPtRcc5uRJ6bCBRkg8EsKabMQkEsMOuVjvEOejVD497WkMgobMbk/X+bdfhPPGdcAHWn5Vnz86SmGdHX5xs6RgYe5jmJCSLiPmB7cjWmxY5ihkCG12Q==",
                        productIntelligenceKey: "wSNX3mu+YGc/2I1DDd0NmrYHS6zS1BQt2geMUH7DDowER43JGeJRUErOHVwU2tz6xHDXia8BuvXQI3j37I0uYw==",
                        terms: "terms for testing")
                    Task{
                        try? await CaptureReceipt.initialize(userId: "testUser123")
                        isInitialized = true
                    }
                }) {
                  Text("Scan")
                            .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
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

                }
            }
        }
    }
}
