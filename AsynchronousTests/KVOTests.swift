//


import XCTest
@testable import Asynchronous

class KVOTests: XCTestCase {
  
  var sut: KVOViewController!
  
  override func setUp() {
    super.setUp()
    let tabBarController = loadTabViewController()
    sut = tabBarController.customizableViewControllers?.first! as? KVOViewController
  }
  
  override func tearDown() {
    sut.resetCount()
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Given
  func givenCountSet() {
    sut.count = 5
  }
  
  // MARK: - Initial
  
  func testController_whenCreated_countLabelIsZero() {
    let count = sut.count
    XCTAssertEqual(0, count)
    
    let text = sut.countLabel.text
    XCTAssertEqual("Count: 0", text)
  }
  
  // MARK: - Change
  
  func testController_whenResetButtonTapped_countLabelIsZero() {
    // given
    givenCountSet()
    let exp = expectation(description: "countLabel changed")
    let observer = LabelObserver()
    observer.observe(sut.countLabel, expectation: exp)
    
    // when
    sut.resetButtonPressed(nil)
    
    // then
    waitForExpectations(timeout: 1, handler: nil)
    
    let count = sut.count
    XCTAssertEqual(0, count)
    
    let text = sut.countLabel.text
    XCTAssertEqual("Count: 0", text)
  }
  
  func testController_whenCountButtonTapped_countLabelAdds() {
    // given
    let exp = expectation(description: "countLabel changed")
    let observer = LabelObserver()
    observer.observe(sut.countLabel, expectation: exp)
    
    // when
    sut.countButtonPressed(nil)
    
    // then
    waitForExpectations(timeout: 1, handler: nil)
    
    let count = sut.count
    XCTAssertEqual(1, count)
    
    let text = sut.countLabel.text
    XCTAssertEqual("Count: 1", text)
  }
  
}
