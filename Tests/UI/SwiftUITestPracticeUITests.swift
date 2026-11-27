import XCTest

final class SwiftUITestPracticeUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testGreetingIsShown() {
        XCTAssertTrue(app.staticTexts["greeting"].waitForExistence(timeout: 5))
    }

    func testEmailActionShowsAlert() {
        app.buttons["emailActionButton"].tap()

        XCTAssertTrue(
            app.alerts["Hello from the app"].waitForExistence(timeout: 5)
        )
        XCTAssertTrue(app.alerts.buttons["OK"].exists)
    }
}