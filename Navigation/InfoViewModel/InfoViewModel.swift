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
            fetchRandomData()
            fetchDataForTable()
            fetchTitle()
            fetchPeriod()
        }
    }
    
    //MARK: Request data for table
    private func fetchDataForTable() {
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
    
    //MARK: Request random data
    private func fetchRandomData() {
        guard let url = URL(string: AppConfiguration.randomURL()) else {
            print("Couldn't get URL")
            return }
        print(url)
        responseSearch.requestRandomData(url: url)
    }
    
    //MARK: Request data about title
    private func fetchTitle() {
        guard let url = URL(string: UsedUrl.jsonPlaceholder) else {
            print("Couldn't get URL")
            return }
        responseSearch.fetchDataAboutTitle(url: url) { [weak self] titleTxt in
            self?.title = titleTxt
        }
    }
    
    //MARK: Request data about orbital period
    private func fetchPeriod() {
        guard let url = URL(string: UsedUrl.swapApi) else {
            print("Couldn't get URL")
            return }
        responseSearch.fetchDataAboutPeriod(url: url) { [weak self] periodTxt in
            self?.orbitalPeriod = periodTxt
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
