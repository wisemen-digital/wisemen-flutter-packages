import UIKit
import Flutter
#if DEBUG && canImport(Atlantis)
import Atlantis
#endif

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    #if DEBUG && canImport(Atlantis)
      Atlantis.start()
    #endif

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
