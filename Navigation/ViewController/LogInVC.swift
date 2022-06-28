import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.tabBarController?.tabBar.backgroundColor = .systemGray6
        
        self.loginTF.delegate = self
        self.passwordTF.delegate = self
        
        setupViews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: LoginScrollView
    private lazy var loginScrollView: UIScrollView = {
        let loginScrollView = UIScrollView()
        loginScrollView.toAutoLayout()
        return loginScrollView
    }()
    // MARK: ContentView
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.toAutoLayout()
        return contentView
    }()
    
    // MARK: LoginFromStackView
    private lazy var loginFormStackView: UIStackView = {
        let loginFormStackView = UIStackView()
        loginFormStackView.toAutoLayout()
        loginFormStackView.axis = .vertical
        loginFormStackView.layer.borderColor = UIColor.lightGray.cgColor
        loginFormStackView.layer.borderWidth = 0.5
        loginFormStackView.layer.cornerRadius = 10
        loginFormStackView.distribution = .fillProportionally
        loginFormStackView.backgroundColor = .systemGray6
        loginFormStackView.clipsToBounds = true
        return loginFormStackView
    }()
    
    
    // MARK: VK Icon
    private lazy var vkIcon: UIImageView = {
        
        let vkIcon = UIImageView()
        
        vkIcon.image = UIImage(named: .vkIconName)
        vkIcon.toAutoLayout()
        
        return vkIcon
    }()
    
    
    // MARK: LogIn Button
    private lazy var logInButton: UIButton = {
        
        let logInButton = UIButton()
        
        logInButton.toAutoLayout()
        
        if let image = UIImage(named: .logInButtonImageName) {
            logInButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            logInButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            logInButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            logInButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        
        logInButton.setTitle(.logInButton, for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        logInButton.layer.cornerRadius = 10
        logInButton.clipsToBounds = true
        return logInButton
        
    }()
    
    // MARK: Login Text Field
    private lazy var loginTF: UITextField = {
        
        let loginTF = UITextField()
        
        loginTF.toAutoLayout()
        loginTF.leftViewMode = .always
        loginTF.placeholder = .loginTF
        loginTF.layer.borderColor = UIColor.lightGray.cgColor
        loginTF.layer.borderWidth = Constants.borderWidth
        loginTF.leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10,
            height: loginTF.frame.height)
        )
        loginTF.keyboardType = .emailAddress
        loginTF.textColor = .black
        loginTF.font = UIFont.systemFont(ofSize: 16)
        loginTF.autocapitalizationType = .none
        loginTF.returnKeyType = .done
        
        
        return loginTF
    }()
    
    // MARK: Password Text Field
    private lazy var passwordTF: UITextField = {
        
        let passwordTF = UITextField()
        
        passwordTF.toAutoLayout()
        passwordTF.leftViewMode = .always
        passwordTF.placeholder = .passwordTF
        passwordTF.layer.borderColor = UIColor.lightGray.cgColor
        passwordTF.layer.borderWidth = Constants.borderWidth
        passwordTF.leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10,
            height: passwordTF.frame.height)
        )
        passwordTF.isSecureTextEntry = true
        passwordTF.textColor = .black
        passwordTF.font = UIFont.systemFont(ofSize: 16)
        passwordTF.autocapitalizationType = .none
        passwordTF.returnKeyType = .done
        
        return passwordTF
    }()
    
    // MARK: Setup View
    private func setupViews() {
        
        view.backgroundColor = .white
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        
        let views: [UIView] = [
            loginFormStackView,
            vkIcon,
            logInButton
        ]
        
        contentView.addSubviews(views)
        
        loginFormStackView.addArrangedSubview(loginTF)
        loginFormStackView.addArrangedSubview(passwordTF)
        
        setupConstraints()
    }
    
    //MARK: Login button action
    @objc private func loginButtonPressed() {
        
        let profileVC = ProfileVC()
        
        navigationController?.pushViewController(profileVC, animated: false)
        navigationController?.setViewControllers([profileVC], animated: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
    
    @objc func tap() {
        passwordTF.resignFirstResponder()
        loginTF.resignFirstResponder()
    }
    
    // MARK: Keyboard state
    @objc func keyboardShow(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            loginScrollView.contentOffset.y = keyboardRectangle.height - (loginScrollView.frame.height - logInButton.frame.minY) + Constants.indent
        }
    }
    
    @objc func keyboardHide(_ notification: Notification){
        loginScrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: loginScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: loginScrollView.centerYAnchor),
            
            vkIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.vkIconLoginFormTop),
            vkIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkIcon.heightAnchor.constraint(equalToConstant: Constants.vkIconLoginFormHeightWidth),
            vkIcon.widthAnchor.constraint(equalToConstant: Constants.vkIconLoginFormHeightWidth),
            
            loginFormStackView.topAnchor.constraint(equalTo: vkIcon.bottomAnchor, constant: Constants.vkIconLoginFormTop),
            loginFormStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            loginFormStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            loginFormStackView.heightAnchor.constraint(equalToConstant: Constants.vkIconLoginFormHeightWidth),
            
            logInButton.topAnchor.constraint(equalTo: loginFormStackView.bottomAnchor, constant: Constants.indent),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.leadingMargin),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.trailingMargin),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.logInButtonHeight),
            
        ])
    }
}
