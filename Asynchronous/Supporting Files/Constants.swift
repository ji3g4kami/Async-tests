
import Foundation

extension Notification.Name {
  enum Custom {
    static let DarkMode = Notification.Name("DarkMode")
    static let LightMode = Notification.Name("LightMode")
    static let Mode = Notification.Name("Mode")
  }
  
  enum Keys {
    static let isDarkMode = "isDarkMode"
  }
}
