import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                         willPresent notification: UNNotification,
                                         withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert) // shows banner even if app is in foreground
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
      UNUserNotificationCenter.current().delegate = self
//      AppDelegate.registerPlugins(with: self) // Register the app's plugins in the context of a normal run
      
//      WorkmanagerPlugin.setPluginRegistrantCallback { registry in
//          // The following code will be called upon WorkmanagerPlugin's registration.
//          // Note : all of the app's plugins may not be required in this context ;
//          // instead of using GeneratedPluginRegistrant.register(with: registry),
//          // you may want to register only specific plugins.
//          AppDelegate.registerPlugins(with: registry)
//      }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
