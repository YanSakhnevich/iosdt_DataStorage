import UIKit

class PostVC: UIViewController {
    private let titlePost: String
    private let viewModel: InfoViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titlePost
        configureItems()
        view.backgroundColor = .systemGreen
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    init(titlePost: String,viewModel: InfoViewModel) {
        self.titlePost = titlePost
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: .postVCInfoSymbolName),
            style: .done,
            target: self,
            action: #selector(didTapButton)
        )
    }
    
    func showModal() {
        let infoVC = InfoVC(viewModel: viewModel)
        present(infoVC, animated: true, completion: nil)
    }
        
    @objc func didTapButton() {
       showModal()        
    }
}
