import Foundation

// MARK: -- Part 1

print("-- Part 1 --\n")

// MARK: Input Data

// Read input data from resource bundle
let inputUrl = Bundle.fixedModule.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputUrl)

// MARK: Processing

struct Matrix<T> {

    // MARK: - State

    var values: [[T]]

    init(_ values: [[T]] = []) {
        self.values = values
    }

    // MARK: - Convenience Accessors

    var rows: [[T]] {
        values
    }

    var columns: [[T]] {
        transposed().values
    }

    // MARK: - Modifiers

    func transposed() -> Self {
        guard let firstRow = values.first else {
            return self
        }
        precondition(values.map(\.count).allSatisfy({ $0 == firstRow.count }), "All rows must be of equal length")
        var matrix = self
        matrix.values = firstRow.indices.map { columnIndex in
            values.map { $0[columnIndex] }
        }
        return matrix
    }
}

struct BingoBoard: CustomStringConvertible {

    struct Field {
        let value: Int
        var isMarked: Bool
    }

    var fields: Matrix<Field>

    /// Parses a bingo board from the raw input
    ///
    /// - Parameter raw: 5 lines of code with 5 numbers each
    init(raw: String) {
        fields = .init(raw.split(separator: "\n").map { line in
            // Ignore empty fields, as these are from duplicate spaces
            line.split(separator: " ").map { value in
                Field(value: Int(value)!, isMarked: false)
            }
        })
    }

    mutating func mark(_ value: Int) {
        for (rowIdx, row) in fields.rows.enumerated() {
            for (columnIdx, field) in row.enumerated() where field.value == value {
                fields.values[rowIdx][columnIdx].isMarked = true
            }
        }
    }

    var description: String {
        // Get the character length of the longest field value
        let columnLength = fields.rows
            .reduce([], +)
            .map { field in
                var length = field.value.description.count
                if field.isMarked {
                    length += 2
                }
                return length
            }
            .max() ?? 0
        // Iterate all fields and pad them to the column length
        return fields.values.map { row -> String in
            row.map { field -> String in
                var val = field.value.description
                if field.isMarked {
                    val = "*\(val)*"
                }
                return String(String(val.reversed())
                    .padding(toLength: columnLength, withPad: " ", startingAt: 0)
                    .reversed())
            }.joined(separator: " ")
        }.joined(separator: "\n")
    }

    var isThisWhatICallABingo: Bool {
        // Check if any row is a bingo
        if fields.rows.contains(where: { row in
            row.allSatisfy(\.isMarked)
        }) {
            return true
        }
        // Check if any column is a bingo
        if fields.columns.contains(where: { column in
            column.allSatisfy(\.isMarked)
        }) {
            return true
        }
        return false
    }

    var sumOfUnmarkedNumbers: Int {
        fields.values.reduce([], +)
            .filter { !$0.isMarked }
            .map(\.value)
            .reduce(0, +)
    }
}

func parseBingoInput(input: String) -> (drawn: [Int], boards: [BingoBoard]) {
    // Format:
    // [1] 1,2,3,4,5        --> array of drawn numbers
    // [2]                  --> empty separator row
    // [3] 22 13 17 11  0   --> 5x5 values separated by whitespace and newlines
    // [4]  8  2 23  4 24
    // [5] 21  9 14 16  7
    // [6]  6 10  3 18  5
    // [7]  1 12 20 15 19
    // [8]                  --> empty separator row
    // [9] ...              --> next bingo board

    // Split the input into segments separated by empty lines
    let segments = input.components(separatedBy: "\n\n")
    // The first segment is dedicated to the drawn numbers, separated by commas
    let drawn = segments[0].split(separator: ",").map { value in
        Int(value)!
    }
    // Remaining segments are bingo boards
    let boards = segments.dropFirst().map { segment in
        BingoBoard(raw: segment)
    }
    return (drawn, boards)
}

public func calculateScore(input: String, wantsToWin: Bool) -> (unmarkedNumbersSum: Int, lastCalledNumber: Int) {
    // Parse the input
    let parsingResult = parseBingoInput(input: input)
    var boards = parsingResult.boards
    var scoreBoard: BingoBoard!
    var lastCalledNumber = -1
    // Helper set to track board indicies which already won
    var winningBoards: Set<Int> = []
    // Iterate all drawn numbers and simulate the marking
    for (roundIdx, number) in parsingResult.drawn.enumerated() {
        lastCalledNumber = number
        // Mark all numbers
        for boardIdx in boards.indices {
            boards[boardIdx].mark(number)
        }
        print("\n-- Round \(roundIdx + 1):\n")
        for (boardIdx, board) in boards.enumerated() {
            print("Board \(boardIdx + 1):\n")
            print(board)
            print()
        }
        // Check for winning board
        if wantsToWin {
            if let winningBoardIndex = boards.firstIndex(where: \.isThisWhatICallABingo) {
                scoreBoard = boards[winningBoardIndex]
                print("Looks like board \(winningBoardIndex + 1) has a bingo!")
                break
            }
        } else {
            let updatedWinningBoardIndicies = Set(boards
                .enumerated()
                .filter(\.element.isThisWhatICallABingo)
                .map(\.offset))
            // if all boards won, compare it with the previous round to find the last one
            if boards.allSatisfy(\.isThisWhatICallABingo) {
                if let lastWinningBoardIdx = updatedWinningBoardIndicies.subtracting(winningBoards).first {
                    scoreBoard = boards[lastWinningBoardIdx]
                    print("Looks like board \(lastWinningBoardIdx + 1) was the last to have a bingo!")
                    break
                }
            } else {
                winningBoards = updatedWinningBoardIndicies
            }
        }
    }
    guard let board = scoreBoard else {
        print("No board has won")
        return (0, 0)
    }
    return (board.sumOfUnmarkedNumbers, lastCalledNumber)
}

// MARK: Output Data

let finalScore = calculateScore(input: input, wantsToWin: true)
print("Result: \(finalScore.unmarkedNumbersSum * finalScore.lastCalledNumber)")

// MARK: -- Part 1

print("\n-- Part 2 --\n")

// MARK: Output Data

let finalScore2 = calculateScore(input: input, wantsToWin: false)
print("Result: \(finalScore2.unmarkedNumbersSum * finalScore2.lastCalledNumber)")
