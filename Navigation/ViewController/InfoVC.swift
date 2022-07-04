import UIKit

class InfoVC: UIViewController {
    
    static let shared = InfoVC()

    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.isOpaque = false
        setupLayout()
        self.residentNameTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        self.residentNameTable.dataSource = self
    }
    
    // MARK: Try Button
    private lazy var tryButton: UIButton = {
        
        let tryButton = UIButton()
        
        tryButton.toAutoLayout()
        
        if let image = UIImage(named: .logInButtonImageName) {
            tryButton.setBackgroundImage(image.image(alpha: 1), for: .normal)
            tryButton.setBackgroundImage(image.image(alpha: 0.8), for: .selected)
            tryButton.setBackgroundImage(image.image(alpha: 0.8), for: .highlighted)
            tryButton.setBackgroundImage(image.image(alpha: 0.8), for: .disabled)
        }
        
        tryButton.setTitle(.infoVCButtonName, for: .normal)
        tryButton.setTitleColor(.white, for: .normal)
        tryButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        tryButton.layer.cornerRadius = 10
        tryButton.clipsToBounds = true
        return tryButton
        
    }()
    
    // MARK: Try Button action
    @objc func didTapButton() {
        Alert.showIncompleteFormAlert(on: self)
    }
    
    // MARK: Title Todos Label
    private lazy var titleTodos: UILabel = {
        let titleTodos = UILabel()
        
        titleTodos.layer.borderColor = UIColor.black.cgColor
        titleTodos.layer.borderWidth = 1.0
        titleTodos.layer.cornerRadius = 5.0

        let boldText = "  Title: "
        let attrsBold = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrsBold)

        let attrsNormal = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .light)]
        let normalString = NSMutableAttributedString(string:NetworkJedi.title, attributes: attrsNormal)
        attributedString.append(normalString)
        titleTodos.attributedText = attributedString

        titleTodos.toAutoLayout()
        titleTodos.numberOfLines = 0
        return titleTodos
    }()
    
    // MARK: Rotation period Label
    private lazy var rotationPeriod: UILabel = {
        let periodOfRotation = UILabel()
        
        periodOfRotation.layer.borderColor = UIColor.black.cgColor
        periodOfRotation.layer.borderWidth = 1.0
        periodOfRotation.layer.cornerRadius = 5.0
        
        let boldText = "  Rotation period: "
        let attrsBold = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrsBold)

        let attrsNormal = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .light)]
        let normalString = NSMutableAttributedString(string:NetworkJedi.orbitalPeriod, attributes: attrsNormal)
        attributedString.append(normalString)
        periodOfRotation.attributedText = attributedString
        
        periodOfRotation.toAutoLayout()
        periodOfRotation.numberOfLines = 0
        return periodOfRotation
    }()
    
    var residentNameTable: UITableView = {
        let personNameTable = UITableView()
        personNameTable.toAutoLayout()
        personNameTable.layer.cornerRadius = 10.0
        personNameTable.backgroundColor = .white
        return personNameTable
        }()

    // MARK: Setup layout
    private func setupLayout() {
        view.addSubview(tryButton)
        view.addSubview(titleTodos)
        view.addSubview(rotationPeriod)
        view.addSubview(residentNameTable)
        setupConstraints()
    }
    
    // MARK: Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constants.buttonOffset),
            tryButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            tryButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingMargin),
            tryButton.heightAnchor.constraint(equalToConstant: Constants.statusTextFieldHeight),
            
            titleTodos.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.indent),
            titleTodos.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            titleTodos.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingMargin),
            titleTodos.heightAnchor.constraint(equalToConstant: Constants.heightInfoLabel),
            
            rotationPeriod.topAnchor.constraint(equalTo: titleTodos.bottomAnchor, constant: Constants.indent),
            rotationPeriod.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            rotationPeriod.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingMargin),
            rotationPeriod.heightAnchor.constraint(equalToConstant: Constants.heightInfoLabel),
            
            residentNameTable.topAnchor.constraint(equalTo: rotationPeriod.bottomAnchor, constant: Constants.statusTextFieldHeight),
            residentNameTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingMargin),
            residentNameTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.trailingMargin),
            residentNameTable.bottomAnchor.constraint(equalTo: tryButton.topAnchor, constant: -Constants.statusTextFieldHeight)
        ])
    }

}

extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.residentNameTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = .systemBackground
        cell.textLabel?.text = "ABC"
           return cell
    }
}

class TableViewCell: UITableViewCell {}
