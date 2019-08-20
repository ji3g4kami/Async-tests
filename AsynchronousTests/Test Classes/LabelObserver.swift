
import XCTest

class LabelObserver: NSObject {
  
  var expectation: XCTestExpectation?
  weak var label: UILabel?
  
  func observe(_ label: UILabel, expectation: XCTestExpectation) {
    self.expectation = expectation
    self.label = label
    
    label.addObserver(self, forKeyPath: "text", options: [.new], context: nil)
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    expectation?.fulfill()
  }
  
  deinit {
    label?.removeObserver(self, forKeyPath: "text")
  }
}
