import Foundation

// MARK: -- Part 1

print("-- Part 1 --\n")

// MARK: Input Data

// Read input data from resource bundle
let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputUrl)
// Split by line and exclude empty ones
let lines = input.components(separatedBy: "\n").filter { $0 != "" }

// MARK: Processing

func transpose<Element>(_ matrix: [[Element]]) -> [[Element]] {
    guard let firstRow = matrix.first else {
        return []
    }
    precondition(matrix.map(\.count).allSatisfy({ $0 == firstRow.count }), "All rows must be of equal length")
    return firstRow.indices.map { columnIndex in
        matrix.map { $0[columnIndex] }
    }
}

func binaryToDecimal(bits: [Int]) -> Int {
    bits.reversed().enumerated().reduce(0) { previous, arg in
        previous + (arg.element << arg.offset)
    }
}

fileprivate func calculateBitCounts(_ matrix: [[String.Element]]) -> [(zeros: Int, ones: Int)] {
    return matrix.map { transposedColumn -> (zeros: Int, ones: Int) in
        let zerosCount = transposedColumn.filter { $0 == "0" }.count
        let onesCount = transposedColumn.filter { $0 == "1" }.count
        return (zeros: zerosCount, ones: onesCount)
    }
}

public func process(lines: [String]) -> (gamma: Int, epsilon: Int) {
    // Map each line into bits to create a bit matrix
    let bitMatrix = lines.map { line in
        Array(line)
    }
    // Transpose the bit matrix so each column is in a row
    let transposedBitMatrix = transpose(bitMatrix)
    // Calculate the common bit per row
    let bitCounts = calculateBitCounts(transposedBitMatrix)
    // Reduce the counts to the common bit
    let mostCommonBits = bitCounts.map { counts in
        counts.zeros > counts.ones ? 0 : 1
    }
    let leastCommonBits = bitCounts.map { counts in
        counts.zeros < counts.ones ? 0 : 1
    }
    // Transform the bits into a decimal
    let gamma = binaryToDecimal(bits: mostCommonBits)
    let epsilon = binaryToDecimal(bits: leastCommonBits)
    return (gamma, epsilon)
}

// MARK: Output Data

let finalPosition = process(lines: lines)
print("Result: \(finalPosition.gamma * finalPosition.epsilon)")

// MARK: -- Part 1

print("\n-- Part 2 --\n")

// MARK: Processing

func reduceLines(bitMatrix: [[String.Element]], columnCount: Int, comparator: (Int, Int) -> Bool) -> Int {
    var reducedLines = bitMatrix
    // Iterate each column and filter down the bit matrix
    for columnIndex in 0..<columnCount {
        // Transpose the bit matrix so each column is in a row
        let transposedBitMatrix = transpose(reducedLines)
        // get the most common value in this column
        // Calculate the common bit per column
        let bitCounts = calculateBitCounts(transposedBitMatrix)
        // If 0 and 1 are equally common, keep values with a 1 in the position being considered
        let counts = bitCounts[columnIndex]
        let commonBit: String.Element = comparator(counts.zeros, counts.ones) ? "0" : "1"
        reducedLines = reducedLines.filter { line in
            line[columnIndex] == commonBit
        }
        if reducedLines.count == 1 {
            break
        }
    }
    let bits = reducedLines[0].map { rawBit in
        Int(String(rawBit))!
    }
    return binaryToDecimal(bits: bits)
}

public func verifyLifeSupportRating(lines: [String]) -> (oxygenGeneratorRating: Int, co2ScrubberRating: Int) {
    // Map each line into bits to create a bit matrix
    let bitMatrix = lines.map { line in
        Array(line)
    }
    let transposedBitMatrix = transpose(bitMatrix)
    let columnCount = transposedBitMatrix.count

    let oxygenGeneratorRating = reduceLines(bitMatrix: bitMatrix, columnCount: columnCount, comparator: >)
    let co2ScrubberRating = reduceLines(bitMatrix: bitMatrix, columnCount: columnCount, comparator: <=)
    return (oxygenGeneratorRating, co2ScrubberRating)
}
// MARK: Output Data

let result2 = verifyLifeSupportRating(lines: lines)
print("Result: \(result2.oxygenGeneratorRating * result2.co2ScrubberRating)")
