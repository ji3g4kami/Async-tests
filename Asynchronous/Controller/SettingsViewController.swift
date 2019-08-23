//
//  SettingsViewController.swift
//  Asynchronous
//
//  Created by udn on 2019/8/21.
//  Copyright © 2019 dengli. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  
  var isDarkMode: Bool = false
  
  @IBOutlet weak var darkModeSwitch: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    isDarkMode ? (darkModeSwitch.isOn = true) : (darkModeSwitch.isOn = false)
  }
  
  func sendModeNotification(isDark: Bool) {
    NotificationCenter.default.post(
      name: Notification.Name.Custom.Mode,
      object: self,
      userInfo: [Notification.Name.Keys.isDarkMode: isDark])
  }

  @IBAction func toggleDarkModeSwitch(_ sender: UISwitch) {
    if sender.isOn {
      sendModeNotification(isDark: true)
    } else {
      sendModeNotification(isDark: false)
    }
  }
  
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
