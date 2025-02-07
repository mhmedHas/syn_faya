import Flutter
import UIKit
import GoogleMaps // إضافة مكتبة Google Maps

@main
@objc class AppDelegate: FlutterAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // تهيئة Google Maps API باستخدام مفتاح API الخاص بك
    GMSServices.provideAPIKey("AIzaSyBY7ciOc5v_4P7axjaocSxxuNg-rjWDzSk") // استبدل "YOUR_GOOGLE_MAPS_API_KEY" بالمفتاح الخاص بك
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
