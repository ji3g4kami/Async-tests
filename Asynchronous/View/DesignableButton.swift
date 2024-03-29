import UIKit
@IBDesignable
class DesignableButton: UIButton {
  
  @IBInspectable var cornerRadius: CGFloat = 5 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
}
