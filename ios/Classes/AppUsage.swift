// Autogenerated from Pigeon (v3.2.3), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
import Flutter

/// Generated class from Pigeon.

enum ResultState: Int {
  case success = 0
  case error = 1
}

/// Generated class from Pigeon that represents data sent in messages.
struct TimeLimitResult {
  var state: ResultState
  var message: String

  static func fromMap(_ map: [String: Any?]) -> TimeLimitResult? {
    let state = ResultState(rawValue: map["state"] as! Int)!
    let message = map["message"] as! String

    return TimeLimitResult(
      state: state,
      message: message
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "state": state.rawValue,
      "message": message
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct UsedApp {
  var id: String
  var name: String
  var minutesUsed: Int32

  static func fromMap(_ map: [String: Any?]) -> UsedApp? {
    let id = map["id"] as! String
    let name = map["name"] as! String
    let minutesUsed = map["minutesUsed"] as! Int32

    return UsedApp(
      id: id,
      name: name,
      minutesUsed: minutesUsed
    )
  }
  func toMap() -> [String: Any?] {
    return [
      "id": id,
      "name": name,
      "minutesUsed": minutesUsed
    ]
  }
}

private class AppUsageApiCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return TimeLimitResult.fromMap(self.readValue() as! [String: Any])      
      case 129:
        return UsedApp.fromMap(self.readValue() as! [String: Any])      
      default:
        return super.readValue(ofType: type)
      
    }
  }
}
private class AppUsageApiCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? TimeLimitResult {
      super.writeByte(128)
      super.writeValue(value.toMap())
    } else if let value = value as? UsedApp {
      super.writeByte(129)
      super.writeValue(value.toMap())
    } else {
      super.writeValue(value)
    }
  }
}

private class AppUsageApiCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return AppUsageApiCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return AppUsageApiCodecWriter(data: data)
  }
}

class AppUsageApiCodec: FlutterStandardMessageCodec {
  static let shared = AppUsageApiCodec(readerWriter: AppUsageApiCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol AppUsageApi {
  func getPlatformVersion(completion: @escaping (String?) -> Void)
  func getApps(completion: @escaping ([UsedApp]) -> Void)
  func setAppTimeLimit(appId: String, durationInMinutes: Int32, completion: @escaping (TimeLimitResult) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class AppUsageApiSetup {
  /// The codec used by AppUsageApi.
  static var codec: FlutterStandardMessageCodec { AppUsageApiCodec.shared }
  /// Sets up an instance of `AppUsageApi` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: AppUsageApi?) {
    let getPlatformVersionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.AppUsageApi.getPlatformVersion", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getPlatformVersionChannel.setMessageHandler { _, reply in
        api.getPlatformVersion() { result in
          reply(wrapResult(result))
        }
      }
    } else {
      getPlatformVersionChannel.setMessageHandler(nil)
    }
    let getAppsChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.AppUsageApi.getApps", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getAppsChannel.setMessageHandler { _, reply in
        api.getApps() { result in
          reply(wrapResult(result))
        }
      }
    } else {
      getAppsChannel.setMessageHandler(nil)
    }
    let setAppTimeLimitChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.AppUsageApi.setAppTimeLimit", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setAppTimeLimitChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let appIdArg = args[0] as! String
        let durationInMinutesArg = args[1] as! Int32
        api.setAppTimeLimit(appId: appIdArg, durationInMinutes: durationInMinutesArg) { result in
          reply(wrapResult(result))
        }
      }
    } else {
      setAppTimeLimitChannel.setMessageHandler(nil)
    }
  }
}

private func wrapResult(_ result: Any?) -> [String: Any?] {
  return ["result": result]
}

private func wrapError(_ error: FlutterError) -> [String: Any?] {
  return [
    "error": [
      "code": error.code,
      "message": error.message,
      "details": error.details
    ]
  ]
}
