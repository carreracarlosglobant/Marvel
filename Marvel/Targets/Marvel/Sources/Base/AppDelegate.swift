import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var coordinator: AppCoordinator?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    let window = UIWindow()
    coordinator = AppCoordinator(window: window)
    coordinator?.start()
    window.makeKeyAndVisible()

    return true
  }

}
