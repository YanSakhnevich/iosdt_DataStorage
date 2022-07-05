import UIKit
import SnapKit

protocol NetworkServiceProtocol {
    func reloadDataInTable()
}

class InfoVC: UIViewController, NetworkServiceProtocol {
    
    private let viewModel: InfoViewModel
    private let spinnerView = UIActivityIndicatorView(style: .large)

    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .initial:
                self.hideContent()
                self.spinnerView.startAnimating()
                
            case .loading:
                self.hideContent()
                self.spinnerView.startAnimating()
                
            case .loaded:
                self.spinnerView.stopAnimating()
                self.showContent()
                self.residentNameTable.reloadData()
                
            case let .error(error):
                print(error)
            }
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.25) {
            self.residentNameTable.alpha = 0
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.25) {
            self.residentNameTable.alpha = 1
        }
    }
    
    
    
    
    
    //MARK: Table reload data for Network Jedi
    func reloadDataInTable() {
        self.residentNameTable.reloadData()
    }
        
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 228/255, green: 229/255, blue: 207/255, alpha: 1)
        view.isOpaque = false
        setupLayout()
        setupViewModel()
        viewModel.send(.viewDidLoad)

        
    }
    
    // MARK: Try Button
    private lazy var tryButton: UIButton = {
        let tryButton = UIButton()
        tryButton.toAutoLayout()
        tryButton.backgroundColor = UIColor(red: 87/255, green: 111/255, blue: 114/255, alpha: 1)
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
    
    lazy var residentNameTable: UITableView = {
        let personNameTable = UITableView()
        personNameTable.toAutoLayout()
        personNameTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        personNameTable.dataSource = self
        personNameTable.delegate = self
        personNameTable.layer.cornerRadius = 10.0
        personNameTable.backgroundColor = .white
        return personNameTable
        }()

    // MARK: Setup layout
    private func setupLayout() {
        let views: [UIView] = [
            tryButton,
            titleTodos,
            rotationPeriod,
            residentNameTable,
            spinnerView
        ]
        view.addSubviews(views)
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
        
        spinnerView.snp.makeConstraints { spiner in
            spiner.centerX.equalTo(self.view.safeAreaLayoutGuide.snp.centerX)
            spiner.centerY.equalTo(self.view.safeAreaLayoutGuide.snp.centerY)
        }
    }

}

extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.residentNameTable.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let name = viewModel.namesArray[indexPath.row]
        cell.backgroundColor = .white
        cell.textLabel?.text = name
           return cell
    }
}

class TableViewCell: UITableViewCell {}
