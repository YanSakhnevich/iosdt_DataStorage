import Foundation
import UIKit

struct NetworkJedi {
    
    static var title = ""
    static var orbitalPeriod = ""
    static let shared = NetworkJedi()
    
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
                print("some error - \(error.localizedDescription)")
                return
            }
            let decodedDataFromURL = String(decoding: data, as: UTF8.self)
            print("data from URL - \(decodedDataFromURL)")
            print("allHeaderFields - \(response.allHeaderFields)")
            print("statusCode - \(response.statusCode)")
        }.resume()
    }
    
    //MARK: Request data about title
    func requestDataAboutTitle() {
        guard let url = URL(string: UsedUrl.jsonPlaceholder) else {
            print("Couldn't get URL")
            return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, responce, error in
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
    func requestDataAboutOrbitalPeriod() {
        guard let url = URL(string: UsedUrl.swapApi) else {
            print("Couldn't get URL")
            return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, responce, error in
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
}
