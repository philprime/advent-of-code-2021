import Foundation

// MARK: -- Part 1

print("-- Part 1 --\n")

// MARK: Input Data

// Read input data from resource bundle
let inputUrl = Bundle.module.url(forResource: "input", withExtension: "txt")!
let input = try String(contentsOf: inputUrl)
// Split by line
let lines = input.components(separatedBy: "\n")
// Parse each line as an integer value
// Pre-Condition: we expect the file content to only contain valid integers
let values = lines.compactMap { Int($0) }

// MARK: Processing

func countIncreasements(values: [Int]) -> Int {
    // Create the pairs to define the differences
    // By dropping the first value of the second array, we zip together the indicies like this:
    // [0]: 0, 1
    // [1]: 1, 2
    // [2]: 2, 3
    // ...
    let pairs = zip(values, values.dropFirst())
    // Map the pairs into their differences
    let diffs = pairs.map { current, next in
        (current: current, next: next, diff: next - current)
    }

    // Count the positive differences, as they mean "the depth has increased"
    return diffs.filter { $0.diff > 0 }.count
}

// MARK: Output Data

print("Result: \(countIncreasements(values: values))")

// MARK: -- Part 1

print("\n-- Part 2 --\n")

// MARK: Processing

func calculateLargerSumCount(values: [Int]) -> Int {
    // The size of the sliding window
    let windowSize = 3
    // The index limit is the total count reduced by the window size
    let indexLimit = values.count - windowSize + 1
    // Map the windows into their sums
    let windowSums = (0..<indexLimit).map { baseIndex -> Int in
        // Get the values in this window
        let windowValues = (0..<windowSize).map { values[baseIndex + $0] }
        // Reduce the values into a sum
        return windowValues.reduce(0, +)
    }
    // Find the number of increased sums
    return countIncreasements(values: windowSums)
}

// MARK: Output Data

print("Result: \(calculateLargerSumCount(values: values))")
