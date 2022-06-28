import UIKit

extension UIImageView {
    
    func roundedImage(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
}
