import XCTest
@testable import LoginAndRegister

class LoginAndRegisterTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func testExample() throws {
        let vc = ChoiceAuthMethodViewController()
        vc.viewDidLoad()
        XCTAssertNotNil(vc.configurator)
        XCTAssertNotNil(vc.presenter)
        XCTAssertNotNil(vc.presenter.router)
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }
}
