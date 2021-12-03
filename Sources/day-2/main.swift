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

enum Movement {

    case forward(Int)
    case down(Int)
    case up(Int)

    init?(from raw: String) {
        let comps = raw.components(separatedBy: " ")
        // Expected format: "<direction> <distance>", e.g. "forward 5"
        guard comps.count >= 2, let distance = Int(comps[1]) else {
            return nil
        }
        switch comps[0] {
        case "forward":
            self = .forward(distance)
        case "down":
            self = .down(distance)
        case "up":
            self = .up(distance)
        default:
            return nil
        }
    }
}

func process(values: [String]) -> (horizontal: Int, depth: Int) {
    var horizontal = 0
    var depth = 0
    // Translate the lines into known movements
    let movements = values.map { value -> Movement in
        guard let movement = Movement(from: value) else {
            preconditionFailure("Invalid value found: \(value)")
        }
        return movement
    }
    // Iterate all movements
    for move in movements {
        switch move {
        case .forward(let distance):
            horizontal += distance
        case .down(let distance):
            depth += distance
        case .up(let distance):
            depth -= distance
        }
    }
    return (horizontal, depth)
}

// MARK: Output Data

let finalPosition = process(values: lines)
print("Result: \(finalPosition.horizontal * finalPosition.depth)")

// MARK: -- Part 1

print("\n-- Part 2 --\n")

// MARK: Processing

func processWithAim(values: [String]) -> (horizontal: Int, depth: Int) {
    var horizontal = 0
    var depth = 0
    var aim = 0
    // Translate the lines into known movements
    let movements = values.map { value -> Movement in
        guard let movement = Movement(from: value) else {
            preconditionFailure("Invalid value found: \(value)")
        }
        return movement
    }
    // Iterate all movements
    for move in movements {
        switch move {
        case .forward(let distance):
            horizontal += distance
            depth += distance * aim
        case .down(let distance):
            aim += distance
        case .up(let distance):
            aim -= distance
        }
    }
    return (horizontal, depth)
}
// MARK: Output Data

let finalPosition2 = processWithAim(values: lines)
print("Result: \(finalPosition2.horizontal * finalPosition2.depth)")
