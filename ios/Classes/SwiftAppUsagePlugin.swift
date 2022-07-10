import Flutter
import UIKit

public class SwiftAppUsagePlugin: NSObject, FlutterPlugin, AppUsageApi {
    var usedApps = [
        UsedApp(id: "com.reddit.app", name: "Reddit", minutesUsed: 75),
        UsedApp(id: "dev.hashnode.app", name: "Hashnode", minutesUsed:37),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25)
    ]

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : AppUsageApi & NSObjectProtocol = SwiftAppUsagePlugin.init()
        AppUsageApiSetup.setUp(binaryMessenger: messenger, api: api)
    }

    func getPlatformVersion(completion: @escaping (String?) -> Void) {
        completion("iOS " + UIDevice.current.systemVersion)
    }

    func getApps(completion: @escaping ([UsedApp]) -> Void) {
        completion(usedApps)
    }

    func setAppTimeLimit(appId: String, durationInMinutes: Int32, completion: @escaping (TimeLimitResult) -> Void) {
        completion(TimeLimitResult(state: ResultState.success, message: "Timer of \(durationInMinutes) minutes set for app ID \(appId)"))
    }
}
