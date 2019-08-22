//
//  SettingsControllerTests.swift
//  AsynchronousTests
//
//  Created by udn on 2019/8/21.
//  Copyright © 2019 dengli. All rights reserved.
//

import XCTest
@testable import Asynchronous

class SettingsControllerTests: XCTestCase {
  
  var sut: SettingsViewController!
  
  let onSwitch: UISwitch = {
    let onSwitch = UISwitch()
    onSwitch.isOn = true
    return onSwitch
  }()
  
  let offSwitch: UISwitch = {
    let onSwitch = UISwitch()
    onSwitch.isOn = false
    return onSwitch
  }()
  
  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
    sut.loadView()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  // MARK: - Given
  func givenIsDarkMode(_ darkMode: Bool) {
    sut.isDarkMode = darkMode
    sut.viewDidLoad()
  }

  // MARK: - Initial State
  
  func testInit_WhenIsNotDarkMode_SwitchIsOff() {
    // given
    givenIsDarkMode(false)
    
    // when
    let isOn: Bool = sut.darkModeSwitch.isOn
    
    // then
    XCTAssertFalse(isOn)
  }
  
  func testInit_WhenIsDarkMode_SwitchIsOn() {
    // given
    givenIsDarkMode(true)
    
    // when
    let isOn: Bool = sut.darkModeSwitch.isOn
    
    // then
    XCTAssertTrue(isOn)
  }
  
  // MARK: - Toggle Switch
  
  func testSwitch_turnOn_generateNotification() {
    let exp = expectation(forNotification: Notification.Name.Custom.DarkMode, object: sut, handler: nil)
    exp.expectedFulfillmentCount = 1
    
    // when
    sut.toggleDarkModeSwitch(onSwitch)
    
    // then
    wait(for: [exp], timeout: 1)
  }
  
  func testSwitch_turnOff_generateNotification() {
    let exp = expectation(forNotification: Notification.Name.Custom.LightMode, object: sut, handler: nil)
    exp.expectedFulfillmentCount = 1
    
    // when
    sut.toggleDarkModeSwitch(offSwitch)
    
    // then
    wait(for: [exp], timeout: 1)
  }
}
