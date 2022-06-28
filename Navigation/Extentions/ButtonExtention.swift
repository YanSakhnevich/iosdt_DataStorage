import UIKit

extension UIButton {
    
    func roundedButtonWithShadow(corderRadius: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float) {
        layer.cornerRadius = corderRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
