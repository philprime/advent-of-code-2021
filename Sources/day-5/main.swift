import Foundation
import lib
import assets

// MARK: -- Part 1

print("-- Part 1 --\n")

// MARK: Input Data

// Read input data from resource bundle
let inputUrl = Files.day5InputTxt.url
let input = try String(contentsOf: inputUrl)

// MARK: Processing

struct Coordinate {

    let x: Int
    let y: Int

    init(raw: String) {
        let comps = raw.components(separatedBy: ",")
        guard comps.count == 2 else {
            preconditionFailure("Invalid coordinate: \(raw)")
        }
        self.x = Int(comps[0])!
        self.y = Int(comps[1])!
    }
}

struct Line {

    let start: Coordinate
    let end: Coordinate

    init(raw: String) {
        let comps = raw.components(separatedBy: " ")
        guard comps.count == 3 else {
            preconditionFailure("Invalid line: \(raw)")
        }
        self.start = Coordinate(raw: comps[0])
        self.end = Coordinate(raw: comps[2])
    }
}

func parseLinesInput(input: String) -> [Line] {
    // Format: x1,y1 -> x2,y2
    input.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { rawLine in
            Line(raw: rawLine)
        }
}

func applyLineToDiagram(diagram: inout Matrix<Int>, line: Line) {
    // Calculate the limits
    let minX = min(line.start.x, line.end.x)
    let maxX = max(line.start.x, line.end.x)
    let minY = min(line.start.y, line.end.y)
    let maxY = max(line.start.y, line.end.y)
    // move along the line, only squared differences are supported
    if (maxX - minX) == (maxY - minY) {
        // move diagonal
        let diffX = line.end.x - line.start.x
        let diffY = line.end.y - line.start.y
        var posX = line.start.x
        var posY = line.start.y
        let distance = abs(diffX)
        for _ in (0...distance) {
            // Increase the counter at the position
            diagram.values[posY][posX] += 1
            // Check if direction is positive or negative
            if diffX < 0 {
                posX -= 1
            } else if diffX > 0 {
                posX += 1
            }
            if diffY < 0 {
                posY -= 1
            } else if diffY > 0 {
                posY += 1
            }
        }
    } else {
        for x in (minX...maxX) {
            for y in (minY...maxY) {
                diagram.values[y][x] += 1
            }
        }
    }
}

func print(diagram: Matrix<Int>) {
    let mapped = diagram.values.map { row in
        row.map { value in
            switch value {
            case 0:
                return "."
            default:
                return value.description
            }
        }.joined()
    }.joined(separator: "\n")
    print(mapped)
}

public func calculateOverlappingPoints(input: String, onlyVertical: Bool) -> Int {
    // Parse the input
    let lines = parseLinesInput(input: input)
    // Calculate the diagram size from the coordinates
    //   To find the size, find the largest coordinates
    let width = lines.map { line in
        max(line.start.x, line.end.x)
    }.max() ?? 0
    let height = lines.map { line in
        max(line.start.y, line.end.y)
    }.max() ?? 0
    // Create the diagram
    var diagram = Matrix(rows: height + 1, columns: width + 1, default: 0)
    // Apply lines to diagram
    for line in lines {
        // Only consider horizontal and vertical lines
        if (line.start.x != line.end.x && line.start.y != line.end.y) && onlyVertical {
            continue
        }
        applyLineToDiagram(diagram: &diagram, line: line)
    }
    print(diagram: diagram)
    // Determine the number of points where at least two lines overlap
    return diagram.count(where: { value in
        value >= 2
    })
}

// MARK: Output Data

let result = calculateOverlappingPoints(input: input, onlyVertical: true)
print("Result: \(result)")

// MARK: -- Part 1

print("\n-- Part 2 --\n")

// MARK: Output Data

let result2 = calculateOverlappingPoints(input: input, onlyVertical: false)
print("Result 2: \(result2)")
