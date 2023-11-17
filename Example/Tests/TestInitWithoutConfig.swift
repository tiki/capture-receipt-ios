import XCTest
import CaptureReceipt

class TestInitWithoutConfig: XCTestCase {

    func testInitializeWithoutConfiguration() async throws {
        do{
            try await CaptureReceipt.initialize(userId: "testUser123")
            XCTFail("no error thrown")
        }catch{
            XCTAssert(true)
        }
    }
    
}
