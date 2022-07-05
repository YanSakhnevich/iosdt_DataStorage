import UIKit


final class InfoViewModel {
    
    var onStateChanged: ((State) -> Void)?
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var title = ""
    var orbitalPeriod = ""
    var namesArray: [String] = []
    private let responseSearch: InfoServiceProtocol = NetworkJedi()

    
    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            state = .loading
            fetch()
        }
    }
    
    private func fetch() {
        guard let url = URL(string: UsedUrl.swapApi) else {
            print("Couldn't get URL")
            return }
        responseSearch.fetchData(url: url) { [weak self] names in
            guard let arrayOfNames = names else { return }
            self?.namesArray = arrayOfNames
            DispatchQueue.main.async {
                self?.state = .loaded
            }
        }
    }
}


extension InfoViewModel {
    
    enum Action {
        case viewDidLoad
    }
    
    enum State {
        case initial
        case loading
        case loaded
        case error(String)
    }
}
