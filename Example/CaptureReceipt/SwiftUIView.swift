/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */


import SwiftUI
import CaptureReceipt

@main
struct RewardsExampleApp: App {
    var body: some Scene {
        WindowGroup {
            Button(action: {
                CaptureReceipt.config(
                    tikiPublishingID: "4a03c7fc-1533-48f4-b0e7-c34e49af91cf",
                    microblinkLicenseKey: "sRwAAAAoY29tLm15dGlraS5zZGsuY2FwdHVyZS5yZWNlaXB0LmNhcGFjaXRvcgY6SQlVDCCrMOCc/jLI1A3BmOhqNvtZLzShMcb3/OLQLiqgWjuHuFiqGfg4fnAiPtRcc5uRJ6bCBRkg8EsKabMQkEsMOuVjvEOejVD497WkMgobMbk/X+bdfhPPGdcAHWn5Vnz86SmGdHX5xs6RgYe5jmJCSLiPmB7cjWmxY5ihkCG12Q==",
                    productIntelligenceKey: "wSNX3mu+YGc/2I1DDd0NmrYHS6zS1BQt2geMUH7DDowER43JGeJRUErOHVwU2tz6xHDXia8BuvXQI3j37I0uYw==",
                    terms: "terms for testing")
                Task{
                    try? await CaptureReceipt.initialize(userId: "testUser123")
                }
            }) {
                HStack (spacing: 5) {
                    Image(systemName: "hand.tap.fill")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                    Text("Click to start")
                        .font(.system(size: 20, weight: .regular, design: .rounded)).clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
