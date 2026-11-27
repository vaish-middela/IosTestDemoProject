import XCTest

 class BaseTest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        if app.state == .running {
            app.terminate()
        }
    }

//- file: StaticString = #filePath is the source file’s path.
// - line: UInt = #line is the line number where waitForElement(...) was called.
// Swift fills in #filePath and #line automatically. Passing them to XCTAssertTrue makes the failure point to the test that called the helper, instead of pointing inside BaseUITest.swift.

    func waitForElement(
        _element: XCUIElement,
        timeout: TimeInterval = 5,
        file: StaticString = #filePath,  
        line: UInt = #line
    ) {
        XCAsserTrue(
            element.waitForExistence(timeout: timeout),
            "Expected the element to appear: \(element)",
            file: file,
            line: line
        )
    }

}