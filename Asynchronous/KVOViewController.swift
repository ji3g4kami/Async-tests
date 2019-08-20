
import UIKit

class KVOViewController: UIViewController {
  
  var count = 0 {
    didSet {
      countLabel.text = "Count: \(count)"
    }
  }
  
  func resetCount() {
    count = 0
  }
  
  @IBOutlet weak var countLabel: UILabel!

  @IBAction func countButtonPressed(_ sender: UIButton?) {
    count += 1
  }

  @IBAction func resetButtonPressed(_ sender: UIButton?) {
    resetCount()
  }
  
}

