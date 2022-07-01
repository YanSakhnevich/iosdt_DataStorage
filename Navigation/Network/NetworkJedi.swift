import Foundation
import UIKit

struct NetworkJedi {
    
    static let shared = NetworkJedi()
    
    func getDataFromURL(url: String) {
        guard let url = URL(string: url) else { return }
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
}
