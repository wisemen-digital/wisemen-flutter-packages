import Flutter
import UIKit

public class WiseScalarsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "wise_scalars", binaryMessenger: registrar.messenger())
    let instance = WiseScalarsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getTemperatureUnit":
      result(getTemperatureUnit())
    case "getUsesMetricSystemForDistance":
      result(getUsesMetricSystemForDistance())
    case "getDateFormatStyles":
      result(getDateFormatStyles())
    case "getFirstDayOfWeek":
      result(getFirstDayOfWeek())
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getTemperatureUnit() -> String {
    switch UnitTemperature(forLocale: .autoupdatingCurrent) {
      case .celsius:
        return "celsius"
      case .fahrenheit:
        return "fahrenheit"
      case .kelvin:
        return "kelvin"
      default:
        return "unknown"
      }
  }

  private func getUsesMetricSystemForDistance() -> Bool? {
    switch Locale.autoupdatingCurrent.measurementSystem {
      case .metric:
        return true
      case .uk:
        return false
      case .us:
        return false
      default:
        return nil
    }
  }

  private func getDateFormatStyles() -> [String: String] {
    var styles: [String: String] = [:]
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    styles["short"] = formatter.dateFormat
    formatter.dateStyle = .medium
    styles["medium"] = formatter.dateFormat
    formatter.dateStyle = .long
    styles["long"] = formatter.dateFormat
    formatter.dateStyle = .full
    styles["full"] = formatter.dateFormat
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    styles["time"] = formatter.dateFormat
    return styles
  }

  private func getFirstDayOfWeek() -> Int? {
    switch Locale.autoupdatingCurrent.firstDayOfWeek {
      case .monday:
          return 1
      case .tuesday:
          return 2
      case .wednesday:
          return 3
      case .thursday:
          return 4
      case .friday:
          return 5
      case .saturday:
          return 6
      case .sunday:
          return 7
      default:
          return nil
    }
  }
}
