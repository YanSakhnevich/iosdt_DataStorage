import UIKit

class InfoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tintColor
        view.isOpaque = false
        
        let button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: 200,
            height: 50)
        )
        view.addSubview(button)
        button.center = view.center
        button.backgroundColor = .systemGray
        button.setTitle(.infoVCButtonName, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(
            self,
            action: #selector(didTapButton),
            for: .touchUpInside
        )
    }

    @objc func didTapButton() {
        Alert.showIncompleteFormAlert(on: self)
    }

}
