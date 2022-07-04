import UIKit

class FeedVC: UIViewController {
    
    private let titlePostVC = Post(title: "Some Post")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        configureStack()
        view.addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.toAutoLayout()
        setupLayout()
    }
   
    var stack = UIStackView()
    
    func configureStack() {
        let _ = ["Button_1", "Button_2"].map { [weak self] txt in
            let button = MyButton()
            button.blueButton(title: txt)
            button.toAutoLayout()
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            self?.stack.addArrangedSubview(button)
        }
    }
    
    @objc func didTapButton() {
        let post = PostVC(titlePost: titlePostVC.title)
        navigationController?.pushViewController(post, animated: true)
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}


struct Post {
    let title: String
}






