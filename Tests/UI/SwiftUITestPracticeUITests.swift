import XCTest


final class SwiftUITestPracticeUITests: BaseTest {

    func testGreetingIsShown() {
        // XCTAssertTrue(app.staticTexts["greeting"].waitForExistence(timeout: 5))
        waitForElement(app.staticTexts["greeting"])
    }

    func testEmailActionShowsAlert() {
        app.buttons["emailActionButton"].tap()
        let alert = app.alerts["Hello from the app"]
        waitForElement(alert)
        waitForElement(alert.button["OK"])

        // XCTAssertTrue(
        //     app.alerts["Hello from the app"].waitForElement(timeout: 5)
        // )
        // XCTAssertTrue(app.alerts.buttons["OK"].exists)
    }
}