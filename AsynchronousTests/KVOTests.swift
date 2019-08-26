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
    // 講解一下重設的問題
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
  
  // MARK: - Use
  func testController_whenResetButtonTapped_countLabelIsZero2() {
    // given
    givenCountSet()
    _ = keyValueObservingExpectation(for: sut.countLabel!, keyPath: "text", expectedValue: "Count: 0")
    // when
    sut.resetButtonPressed(nil)
    
    // then
    waitForExpectations(timeout: 1, handler: nil)
    
  }
  
  // 解釋一下 wait(for: <#T##[XCTestExpectation]#>, timeout: <#T##TimeInterval#>, enforceOrder: <#T##Bool#>) 跟 waitForExpectations(timeout: <#T##TimeInterval#>, handler: <#T##XCWaitCompletionHandler?##XCWaitCompletionHandler?##(Error?) -> Void#>) 差別
  
  func testController_whenCountButtonTapped_countLabelAdds2() {
    
    let exp = keyValueObservingExpectation(for: sut.countLabel!, keyPath: "text", expectedValue: "Count: 1")
    
    // when
    sut.countButtonPressed(nil)
    
    // then
    wait(for: [exp], timeout: 1, enforceOrder: false)
  }
  
  
}
