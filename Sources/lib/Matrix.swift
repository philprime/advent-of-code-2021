public struct Matrix<T> {

    // MARK: - State

    public var values: [[T]]

    public init(rows: Int, columns: Int, default value: T) {
        values = Array(repeating: Array(repeating: value, count: columns), count: rows)
    }

    public init(_ values: [[T]] = []) {
        self.values = values
    }

    // MARK: - Convenience Accessors

    public var rows: [[T]] {
        values
    }

    public var columns: [[T]] {
        transposed().values
    }

    // MARK: - Modifiers

    public func transposed() -> Self {
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

    // MARK: - Collection Accessors

    public func count(where isIncluded: (T) -> Bool) -> Int {
        values.reduce([], +)
            .filter(isIncluded)
            .count
    }
}
