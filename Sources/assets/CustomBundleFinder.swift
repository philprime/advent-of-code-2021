import Foundation

internal class CustomBundleFinder {

    /// Returns the resource bundle associated with the current Swift module.
    internal static var module: Bundle = {
        let bundleName = "advent-of-code-2021_assets"

        let candidates = [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: CustomBundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL,

            // Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/")
            Bundle(for: CustomBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent(),
            Bundle(for: CustomBundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent()
        ]

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("unable to find bundle named advent-of-code-2021_assets")
    }()
}
