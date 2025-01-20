import UIKit
import Flutter
#if DEBUG && canImport(Atlantis)
import Atlantis
#endif

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    #if DEBUG && canImport(Atlantis)
      Atlantis.start()
    #endif

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
