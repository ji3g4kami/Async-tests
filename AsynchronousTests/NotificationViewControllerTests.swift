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
    vc.sendModeNotification(Notification.Name.Custom.DarkMode)
  }
  
  func whenSettingsViewControllerSendLightModeNotification(vc: SettingsViewController) {
    vc.sendModeNotification(Notification.Name.Custom.LightMode)
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
    let exp = expectation(forNotification: Notification.Name.Custom.DarkMode, object: settingsVC, handler: nil)
    exp.expectedFulfillmentCount = 1
    sut.notification.addObserver(forName: Notification.Name.Custom.DarkMode, object: settingsVC, queue: nil) { _ in
      exp.fulfill()
    }
    
    // when
    whenSettingsViewControllerSendDarkModeNotification(vc: settingsVC)
    
    // then
    wait(for: [exp], timeout: 1)
    XCTAssertTrue(sut.isDarkMode)
  }
  
  func testWhenReceivedLightModeNotification_isNotDarkMode() {
    // given
    let settingsVC = givenSettingsViewController()
    let exp = expectation(forNotification: Notification.Name.Custom.LightMode, object: settingsVC, handler: nil)
    exp.expectedFulfillmentCount = 1
    sut.notification.addObserver(forName: Notification.Name.Custom.LightMode, object: nil, queue: nil) { _ in
      exp.fulfill()
    }
    
    // when
    whenSettingsViewControllerSendLightModeNotification(vc: settingsVC)
    
    // then
    wait(for: [exp], timeout: 1)
    XCTAssertFalse(sut.isDarkMode)
  }
}
