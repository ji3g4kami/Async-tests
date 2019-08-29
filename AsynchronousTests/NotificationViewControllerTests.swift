//
//  NotificationViewControllerTests.swift
//  AsynchronousTests
//
//  Created by udn on 2019/8/21.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import Asynchronous

class NotificationViewControllerTests: XCTestCase {
  
  var sut: NotificationViewController!
  
  override func setUp() {
    super.setUp()
    let tabBarController = loadTabViewController()
    sut = tabBarController.customizableViewControllers?[1] as? NotificationViewController
    sut.loadView()
    sut.viewDidLoad()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Given
  func givenSettingsViewController() -> SettingsViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
    return settingsVC
  }
  
  // MARK: - When
  func whenSettingsViewControllerSendDarkModeNotification(vc: SettingsViewController) {
    vc.sendModeNotification(isDark: true)
  }
  
  func whenSettingsViewControllerSendLightModeNotification(vc: SettingsViewController) {
    vc.sendModeNotification(isDark: false)
  }
  
  // MARK: - Initial
  
  func testController_whenCreated_isNotDarkMode() {
    // when loaded, then
    let isDarkMode: Bool = sut.isDarkMode
    XCTAssertFalse(isDarkMode)
  }
  
  func testＷhenReceivedDarkModeNotification_isDarkMode() {
    // given
    let settingsVC = givenSettingsViewController()
    let exp = expectation(forNotification: Notification.Name.Custom.Mode, object: settingsVC, handler: nil)
    var isDarkMode: Bool?
    sut.notification.addObserver(forName: Notification.Name.Custom.Mode, object: settingsVC, queue: nil) { notification in
      let info = notification.userInfo
      isDarkMode = info?[Notification.Name.Keys.isDarkMode] as? Bool
    }
    
    // when
    whenSettingsViewControllerSendDarkModeNotification(vc: settingsVC)
    
    // then
    wait(for: [exp], timeout: 1)
    XCTAssertNotNil(isDarkMode)
    XCTAssertEqual(isDarkMode, true)
    XCTAssertTrue(sut.isDarkMode)
  }
  
  func testWhenReceivedLightModeNotification_isNotDarkMode() {
    // given
    let settingsVC = givenSettingsViewController()
    var isDarkMode: Bool?

    let exp = expectation(forNotification: NSNotification.Name.Custom.Mode, object: settingsVC) { notification in
        let info = notification.userInfo
        isDarkMode = info?[Notification.Name.Keys.isDarkMode] as? Bool
        return isDarkMode == false
    }
    
    // when
    whenSettingsViewControllerSendLightModeNotification(vc: settingsVC)
    
    // then
    wait(for: [exp], timeout: 1)
    XCTAssertNotNil(isDarkMode)
    XCTAssertEqual(isDarkMode, false)
    XCTAssertFalse(sut.isDarkMode)
  }
}
