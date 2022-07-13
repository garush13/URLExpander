import XCTest
@testable import URLExpander

final class URLExpanderTests: XCTestCase {
    func testExpander() async throws {
        let url = URL(string: "https://bit.ly/3ASf9fI")!
        let pathToCompare = "https://webhook.site/89c22467-480d-4457-aa7d-eb8228bb8635"
        if #available(macOS 12.0, *) {
            let expandedURL = await URLExpander.shared.expand(url: url)
            var path = expandedURL?.absoluteString
            XCTAssertEqual(path, pathToCompare)
            path = nil
            
            let expectation = self.expectation(description: "Handling")
            
            URLExpander.shared.expand(url: url) { expandedURL in
                let expandedPath = expandedURL?.absoluteString
                path = expandedPath
                expectation.fulfill()
            }
            
            await waitForExpectations(timeout: 15, handler: nil)
            XCTAssertEqual(path, pathToCompare)
            
        } else {
            URLExpander.shared.expand(url: url) { expandedURL in
                let path = expandedURL?.absoluteString
                XCTAssertEqual(path, pathToCompare)
            }
        }
    }
}
