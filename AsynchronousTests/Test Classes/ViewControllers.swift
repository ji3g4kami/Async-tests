import UIKit
@testable import Asynchronous

func loadTabViewController() -> UITabBarController {
  let window = UIApplication.shared.windows[0]
  return window.rootViewController as! UITabBarController
}
