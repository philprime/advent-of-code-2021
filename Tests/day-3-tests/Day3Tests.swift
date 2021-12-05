import XCTest
@testable import day_3

class Day3Tests: XCTestCase {

    func testProcessing_exampleData_shouldReturnExampleResult() {
        let lines = [
            "00100",
            "11110",
            "10110",
            "10111",
            "10101",
            "01111",
            "00111",
            "11100",
            "10000",
            "11001",
            "00010",
            "01010"
        ]
        let result = process(lines: lines)
        XCTAssertEqual(result.gamma, 22)
        XCTAssertEqual(result.epsilon, 9)
    }

    func testLifeSupportRating_exampleData_shouldReturnExampleResult() {
        let lines = [
            "00100",
            "11110",
            "10110",
            "10111",
            "10101",
            "01111",
            "00111",
            "11100",
            "10000",
            "11001",
            "00010",
            "01010"
        ]
        let result = verifyLifeSupportRating(lines: lines)
        XCTAssertEqual(result.oxygenGeneratorRating, 23)
        XCTAssertEqual(result.co2ScrubberRating, 10)
    }
}
