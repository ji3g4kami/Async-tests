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
  
  func sendModeNotification(_ name: Notification.Name) {
    NotificationCenter.default.post(name: name, object: self)
  }

  @IBAction func toggleDarkModeSwitch(_ sender: UISwitch) {
    if sender.isOn {
      sendModeNotification(Notification.Name.Custom.DarkMode)
    } else {
      sendModeNotification(Notification.Name.Custom.LightMode)
    }
  }
  
  @IBAction func dismissButtonPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
}
