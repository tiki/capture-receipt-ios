import XCTest
import CaptureReceipt

class TestUploadEmail: XCTestCase {

    func testUploadEmail() {
        ReceiptService.uploadEmail(senderEmail: "Test", emailBody: "Test", attachments: ["Test1", "Test2"])
        sleep(10)
    }
}
