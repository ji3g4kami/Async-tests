//
//  NotificationViewController.swift
//  Asynchronous
//
//  Created by udn on 2019/8/21.
//  Copyright © 2019 dengli. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {

  @IBOutlet weak var modeLabel: UILabel!
  @IBOutlet weak var settingsButton: UIButton!
  
  let notification = NotificationCenter.default
  
  var isDarkMode: Bool = false {
    didSet {
      if isDarkMode {
        modeLabel.text = "Dark Mode"
        modeLabel.textColor = .white
        view.backgroundColor = .black
        settingsButton.imageView?.image = #imageLiteral(resourceName: "settings_white")
      } else {
        modeLabel.text = "Light Mode"
        modeLabel.textColor = .black
        view.backgroundColor = .white
        settingsButton.imageView?.image = #imageLiteral(resourceName: "settings")
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservers()
  }
  
  func setupObservers() {
    notification.addObserver(forName: Notification.Name.Custom.Mode, object: nil, queue: .main) { [unowned self] notification in
      if let info = notification.userInfo, let isDarkMode = info[Notification.Name.Keys.isDarkMode] as? Bool {
        self.isDarkMode = isDarkMode
      }
    }
  }

  deinit {
    notification.removeObserver(self)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toSettings", let destination = segue.destination as? SettingsViewController {
      destination.isDarkMode = isDarkMode
    }
  }

}
