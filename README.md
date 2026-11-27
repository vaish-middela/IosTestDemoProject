This is for ios naitve app testing learning project:

### Waits:

1. XCTNSPredicateExpectation (Waiting for States & Spinners)

When you need to wait for an element to disappear (like a loading spinner), become enabled, or change its value,

    ```
    // Put this inside your BaseTest class
    func waitForElementToDisappear(_ element: XCUIElement, timeout: TimeInterval = 10) {
        let predicate = NSPredicate(format: "exists == false")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, "Element \(element) did not disappear within \(timeout)s")
    }

    func waitForElementToBeHittable(_ element: XCUIElement, timeout: TimeInterval = 5) {
        let predicate = NSPredicate(format: "exists == true AND isHittable == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        XCTAssertEqual(result, .completed, "Element \(element) never became hittable")
    }

    ----
    TEST USAGE:

    app.buttons["Submit Order"].tap()

    // Wait until the loading spinner vanishes before checking the next screen
    let spinner = app.activityIndicators["loading_spinner"]
    waitForElementToDisappear(spinner)

    XCTAssertTrue(app.staticTexts["Order Confirmed"].exists)
    ```

2. Most common - waitForExistence
   let profileTitle = app.staticTexts["My Profile"]
   XCTAssertTrue(profileTitle.waitForExistence(timeout: 5))

3. wait(for:toEqual:timeout:) (Modern Xcode 15+ Shorthand)
   ```
   let submitButton = app.buttons["Submit"]
   // Waits until submitButton.isEnabled becomes true
   XCTAssertTrue(submitButton.wait(for: \.isEnabled, toEqual: true, timeout: 5))
   ```

## Quick Comparison: Espresso vs. XCUITest

| Scenario                                | Android (Espresso)                                                                                             | iOS (XCUITest)                                           |
| --------------------------------------- | -------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| **UI synchronization**                  | Waits for the main thread and registered `IdlingResource`s to become idle.                                     | Waits for the app’s UI to become ready for interaction.  |
| **Assert that a view appears**          | `onView(matcher).check(matches(isDisplayed()))`; register an `IdlingResource` for app-managed background work. | `element.waitForExistence(timeout:)`                     |
| **Wait for a spinner to be removed**    | Use an `IdlingResource` to track the work that the spinner represents, then assert it is gone.                 | `spinner.waitForNonExistence(timeout:)`                  |
| **Wait for a button to become enabled** | Track the operation with an `IdlingResource`, then assert with `matches(isEnabled())`.                         | `button.wait(for: \.isEnabled, toEqual: true, timeout:)` |
