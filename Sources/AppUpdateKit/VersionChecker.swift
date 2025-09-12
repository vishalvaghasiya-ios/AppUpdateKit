import Foundation
import UIKit

public enum UpdateResult {
    case updateAvailable(String)
    case upToDate
    case error(Error)
}

@MainActor
public final class AppUpdateKit {
    public static let shared = AppUpdateKit()
    private init() {}

    public func checkForUpdate(appID: String = "<YOUR_APP_ID>", completion: @escaping (UpdateResult) -> Void) {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            completion(.error(NSError(domain: "AppUpdateKit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Current version not found"])))
            return
        }
        let lookupURL = URL(string: "https://itunes.apple.com/lookup?id=\(appID)&timestamp=\(Date().timeIntervalSince1970)")!

        let task = URLSession.shared.dataTask(with: lookupURL) { data, _, error in
            if let error = error {
                completion(.error(error))
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let results = json["results"] as? [[String: Any]],
                  let storeVersion = results.first?["version"] as? String
            else {
                completion(.error(NSError(domain: "AppUpdateKit", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to parse App Store response"])))
                return
            }

            if storeVersion.compare(currentVersion, options: .numeric) == .orderedDescending {
                completion(.updateAvailable(storeVersion))
            } else {
                completion(.upToDate)
            }
        }
        task.resume()
    }
}
