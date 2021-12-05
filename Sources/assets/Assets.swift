// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length line_length implicit_return

// MARK: - Files

// swiftlint:disable explicit_type_interface identifier_name
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Files {
  /// day-5-input.txt
  public static let day5InputTxt = File(name: "day-5-input", ext: "txt", relativePath: "", mimeType: "text/plain")
}
// swiftlint:enable explicit_type_interface identifier_name
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

public struct File {
  public let name: String
  public let ext: String?
  public let relativePath: String
  public let mimeType: String

  public var url: URL {
    return url(locale: nil)
  }

  public func url(locale: Locale?) -> URL {
    let bundle = CustomBundleFinder.module
    let url = bundle.url(
      forResource: name,
      withExtension: ext,
      subdirectory: relativePath,
      localization: locale?.identifier
    )
    guard let result = url else {
      let file = name + (ext.flatMap { ".\($0)" } ?? "")
      fatalError("Could not locate file named \(file)")
    }
    return result
  }

  public var path: String {
    return path(locale: nil)
  }

  public func path(locale: Locale?) -> String {
    return url(locale: locale).path
  }
}
