import UIKit

protocol InfoServiceProtocol {
    func fetchData(url: URL?, response: @escaping ([String]?) -> Void)
    func requestRandomData(url: URL?)
    func fetchDataAboutTitle(url: URL?, response: @escaping (String) -> Void)
    func fetchDataAboutPeriod(url: URL?, response: @escaping (String) -> Void)
}

struct NetworkJedi: InfoServiceProtocol {
    
    //MARK: Request data about orbital period
    func fetchDataAboutPeriod(url: URL?, response: @escaping (String) -> Void) {
        guard let url = url else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try? JSONDecoder().decode(PlanetModel.self, from: data) {
                    response(json.orbitalPeriod)
                } else {
                    print("Failed to decode")
                }
            }
        }.resume()
    }
    
    //MARK: Request data about title
    func fetchDataAboutTitle(url: URL?, response: @escaping (String) -> Void) {
        guard let url = url else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let title = json["title"] as? String else { return }
                    response(title)
                } else {
                    print("Failed to serialize")
                }
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
  
    // MARK: Request from swapi.dev task 1.1
    func requestRandomData(url: URL?) {
        guard let url = url else {
            print("Couldn't get URL")
            return }
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
    
    //MARK: Request data about name
    private func request(url: String, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: url) else {
            print("Couldn't get URL")
            return }
        URLSession.shared.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
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
    
    //MARK: Request data with names array
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
}
