import XCTest


final class SwiftUITestPracticeUITests: BaseTest {


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