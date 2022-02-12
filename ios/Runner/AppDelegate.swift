import UIKit
import Flutter
import Firebase
import GoogleMobileAds

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "da4cd32310d009a994d3d317e46037b0" ]
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
