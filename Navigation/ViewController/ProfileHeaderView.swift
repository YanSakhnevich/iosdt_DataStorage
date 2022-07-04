import UIKit
import SnapKit


class ProfileHeaderView: UITableViewHeaderFooterView {
    
    private(set) var statusText: String = ""
    
    static let identifire = "ProfileHeaderView"
    
    // MARK: Add Subviews
    func addView() {
        let views: [UIView] = [
            logoImageView,
            nameLabel,
            statusLabel,
            statusTextField,
            showStatusButton
        ]
        contentView.addSubviews(views)

        setupConstraints()
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        addView()
        statusTextField.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Add logoImageView
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: Constants.logoImage)
        logoImageView.toAutoLayout()
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = Constants.logoImageViewCornerRadius
        logoImageView.layer.borderWidth = Constants.logoImageViewBorderWidth
        logoImageView.layer.borderColor = Constants.logoImageViewBorderColor
        
        return logoImageView
    }()
    
    // MARK: Add nameLabel
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.toAutoLayout()
        nameLabel.text = .nameLabelText
        nameLabel.textColor = Constants.nameLabelColor
        nameLabel.font = Constants.nameLabelFont
        
        return nameLabel
    }()
    
    // MARK: Add statusLabel
    lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.toAutoLayout()
        statusLabel.text = .statusLabelText
        statusLabel.numberOfLines = Constants.statusLabelNumberOfLines
        statusLabel.textColor = Constants.statusLabelColor
        statusLabel.font = Constants.statusLabelFont
        
        return statusLabel
    }()
    
    // MARK: Add showStatusButton
    lazy var showStatusButton: UIButton = {
        let showStatusButton = UIButton()
        showStatusButton.toAutoLayout()
        showStatusButton.backgroundColor = Constants.showStatusButtonColor
        showStatusButton.roundedButtonWithShadow(
            corderRadius: Constants.showStatusButtonCornerRadius,
            shadowOffset: Constants.showStatusShadowOffset,
            shadowRadius: Constants.showStatusShadowRadius,
            shadowColor: Constants.showStatusShadowColor,
            shadowOpacity: Constants.showStatusShadowOpacity
        )
        showStatusButton.setTitle(.showStatusButtonText, for: .normal)
        showStatusButton.setTitleColor(.lightGray, for: .highlighted)
        showStatusButton.addTarget(self,
                                   action: #selector(pressButton),
                                   for: .touchUpInside
        )
        
        return showStatusButton
    }()
    
    
    
    // MARK: Add statusTextField
    lazy var statusTextField: UITextField = {
        
        let statusTextField = UITextField()
        statusTextField.toAutoLayout()
        statusTextField.roundedTextField(
            cornerRadius: Constants.statusTextFieldCornerRadius,
            borderWidth: Constants.statusTextFieldBorderWidth,
            borderColor: Constants.statusTextFieldBorderColor
        )
        statusTextField.backgroundColor = Constants.statusTextFieldBackgroundColor
        statusTextField.font = Constants.statusTextFieldFont
        statusTextField.textColor = Constants.statusTextFieldColor
        statusTextField.leftView = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: 10,
                                                        height: statusTextField.frame.height)
        )
        statusTextField.leftViewMode = .always
        statusTextField.placeholder = .placeholderText
        statusTextField.addTarget(self,
                                  action: #selector(statusTextChanged),
                                  for: .editingChanged
        )
        statusButtonDisable()
        
        return statusTextField
    }()
    
 
    
    // MARK: Button Action
    @objc func pressButton(){
        if statusLabel.text != nil && statusText != "" {
            statusLabel.text = statusText
            statusTextField.text = ""
            statusTextField.resignFirstResponder()
            statusButtonDisable()
            
        }
    }
    
    // MARK: statusButton state
    @objc func statusButtonEnable(){
        showStatusButton.isEnabled = true
        showStatusButton.alpha = 1
        
    }
    
    @objc func statusButtonDisable(){
        showStatusButton.isEnabled = false
        showStatusButton.alpha = 0.5
        
    }
    
    //MARK: TextField Action
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        statusButtonEnable()
        statusText = text
        showStatusButton.resignFirstResponder()
    }
    
    // MARK: Setting layout constraints with SnapKit
    private func setupConstraints() {
        
        logoImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(Constants.padding)
            make.top.equalTo(contentView.snp.top).offset(Constants.padding)
            make.size.equalTo(CGSize(width: Constants.logoImageViewWidth, height: Constants.logoImageViewWidth))
        }

        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(Constants.padding)
        }

        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
        }

        statusTextField.snp.makeConstraints { make in
            make.height.equalTo(Constants.statusTextFieldHeight)
            make.trailing.equalTo(contentView.snp.trailing).offset(-Constants.padding)
            make.top.equalTo(statusLabel.snp.bottom).offset(Constants.padding)
            make.leading.equalTo(statusLabel.snp.leading)
            make.bottom.equalTo(showStatusButton.snp.top).offset(-Constants.statusTextFieldBottomAnchor)
        }

        showStatusButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.showStatusButtonHeight)
            make.leading.equalTo(contentView.snp.leading).offset(Constants.padding)
            make.width.equalTo(Constants.showStatusButtonWidth)
            make.top.equalTo(logoImageView.snp.bottom).offset(Constants.padding*2)
        }
    }
}

// MARK: Extention
extension ProfileHeaderView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == " " {
            return false
        }
        return true
        
    }
}
