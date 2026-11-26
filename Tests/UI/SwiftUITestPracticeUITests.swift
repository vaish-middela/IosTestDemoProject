import SwiftUI

final class SwiftUITestPracticeUITests: XCTestCase{
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

    }

    fun testGreetingIsShown(){
        XCTAssertTrue(app.staticTexts["greeting"].waitForExistence(timeout: 5))
    }

    fun testEmailActionShowsAlert(){
        app.buttons["emailActionButton"].tap()

        XCTAssertTrue(
            app.alerts["Hello from the app"].waitForExistence(timeout: 5)

        )
        XCTAssertTrue(app.alerts.buttons["OK"].exists)
    }
}