import XCTest
import CaptureReceipt

class TestInitWithoutConfig: XCTestCase {

    func testInitializeWithoutConfiguration() async throws {
        do{
            XCTFail("no error thrown")
        }catch{
            XCTAssert(true)
        }
    }
    
}
