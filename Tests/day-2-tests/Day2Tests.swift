import XCTest
@testable import day_2

class Day2Tests: XCTestCase {

    func testProcessing_exampleData_shouldReturnExampleResult() {
        let lines = [
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2"
        ]
        let result = process(values: lines)
        XCTAssertEqual(result.horizontal, 15)
        XCTAssertEqual(result.depth, 10)
    }

    func testProcessingWithAim_exampleData_shouldReturnExampleResult() {
        let lines = [
            "forward 5",
            "down 5",
            "forward 8",
            "up 3",
            "down 8",
            "forward 2"
        ]
        let result = processWithAim(values: lines)
        XCTAssertEqual(result.horizontal, 15)
        XCTAssertEqual(result.depth, 60)
    }
}
