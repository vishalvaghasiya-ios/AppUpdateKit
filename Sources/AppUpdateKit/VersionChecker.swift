import Foundation
import UIKit

@MainActor
public final class VersionChecker {
    private init() {}

    /// One-liner method to check for update and show alert
    public static func check(appID: String, on viewController: UIViewController) {
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0"
        let lookupURL = URL(string: "https://itunes.apple.com/lookup?id=\(appID)&timestamp=\(Date().timeIntervalSince1970)")!
        let appStoreURL = URL(string: "https://apps.apple.com/app/id\(appID)&timestamp=\(Date().timeIntervalSince1970)")!

        let task = URLSession.shared.dataTask(with: lookupURL) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let storeVersion = results.first?["version"] as? String
            else { return }

            if storeVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                DispatchQueue.main.async {
                    let alert = UIAlertController(
                        title: "Update Available",
                        message: "A new version of the app is available. Please update to continue.",
                        preferredStyle: .alert
                    )

                    alert.addAction(UIAlertAction(title: "Update", style: .default) { _ in
                        UIApplication.shared.open(appStoreURL)
                    })

                    alert.addAction(UIAlertAction(title: "Later", style: .cancel))

                    viewController.present(alert, animated: true)
                }
            }
        }
        task.resume()
    }
}
