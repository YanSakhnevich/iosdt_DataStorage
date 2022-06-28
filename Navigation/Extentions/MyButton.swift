import UIKit

class MyButton: UIButton {
    
    func blueButton(title: String) {
        
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        setTitle("\(title)", for: .normal)
        layer.cornerRadius = 12
      
    }
}
