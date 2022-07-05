import UIKit

protocol InfoServiceProtocol {
    func fetchData(url: URL?, response: @escaping ([String]?) -> Void)
}

struct NetworkJedi: InfoServiceProtocol {
    
//    private func request1(url: String, completion: @escaping (Result<String, Error>) -> Void) {
//        
//        guard let url = URL(string: url) else {
//            print("Couldn't get URL")
//            return }
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else { return }
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                guard let name = json["name"] as? String else { return }
//                completion(.success(name))
//            }
//        }.resume()
//    }
    
    private func request(url: String, completion: @escaping (String?) -> Void) {
        
        guard let url = URL(string: url) else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let name = json["name"] as? String else { return }
                    completion(name)
                } else {
                    print("Failed to serialize")
                }
            }
            catch let error {
                print(error)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchData(url: URL?, response: @escaping ([String]?) -> Void) {
        guard let url = url else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try? JSONDecoder().decode(PlanetModel.self, from: data) {
                    let peopleArray = json.residents
                    var namesArray = [String]()
                    let group = DispatchGroup()
                    for people in peopleArray {
                        group.enter()
                        request(url: people) { (name) in
                            guard let name = name else {
                                group.leave()
                                return }
                            namesArray.append(name)
                            group.leave()
                        }
                        group.notify(queue: .main) {
                            response(namesArray)
                        }
                    }
                } else {
                    print("Failed to decode")
                }
            }
        }.resume()
    }
    
 
    // -----------------------------------------------------------------------------------------------------
    static var title = ""
    static var orbitalPeriod = ""
    static var namesArray: [String] = []
    static let shared = NetworkJedi()
//    private let reloadTable: NetworkServiceProtocol = InfoVC()
    
    // MARK: Request from swapi.dev task 1.1
    func requestRandomData() {
        guard let url = URL(string: AppConfiguration.randomURL()) else {
            print("Couldn't get URL")
            return }
        print(url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                guard let error = error else { return }
                print("Some error - \(error.localizedDescription)")
                return
            }
            let decodedDataFromURL = String(decoding: data, as: UTF8.self)
            print("Data from URL - \(decodedDataFromURL)")
            print("AllHeaderFields - \(response.allHeaderFields)")
            print("StatusCode - \(response.statusCode)")
        }.resume()
    }
    
    //MARK: Request data about title
    func requestDataAboutTitle() {
        guard let url = URL(string: UsedUrl.jsonPlaceholder) else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let title = json["title"] as? String else { return }
                    NetworkJedi.title = title
                } else {
                    print("Failed to serialize")
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
    
    //MARK: Request data about orbital period
    func requestPeriod() {
        guard let url = URL(string: UsedUrl.swapApi) else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try? JSONDecoder().decode(PlanetModel.self, from: data) {
                    NetworkJedi.orbitalPeriod = json.orbitalPeriod
                } else {
                    print("Failed to decode")
                }
            }
        }.resume()
    }
//
//    //MARK: Request data about names
//    func requestNames(url: String) {
//        guard let url = URL(string: url) else {
//            print("Couldn't get URL")
//            return }
//        URLSession.shared.dataTask(with: url) { data, responce, error in
//            guard let data = data else { return }
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    guard let name = json["name"] as? String else { return }
//                    NetworkJedi.namesArray.append(name)
//                } else {
//                    print("Failed to serialize")
//                }
//            }
//            catch let error {
//                print(error)
//            }
//        }.resume()
//    }
    //--------------------------------------------------------------------------------------------------------------
}
