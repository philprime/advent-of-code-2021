import XCTest
@testable import day_5

class Day5Tests: XCTestCase {

    let input = """
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    """

    func test_verticalOnly_shouldReturnExampleResult() {
        let result = calculateOverlappingPoints(input: input, onlyVertical: true)
        XCTAssertEqual(result, 5)
    }

    func test_allLines_shouldReturnExampleResult() {
        let result = calculateOverlappingPoints(input: input, onlyVertical: false)
        XCTAssertEqual(result, 12)
    }
}
