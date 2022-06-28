import Foundation

enum AppConfiguration: String {
    case url1 = "https://swapi.dev/api/films/3"
    case url2 = "https://swapi.dev/api/starships/5"
    case url3 = "https://swapi.dev/api/planets/9"
}

extension AppConfiguration: CaseIterable {
    static func randomURL() -> String {
        guard let result = allCases.randomElement()?.rawValue else {
            return "Упс, не получается получить рандомный URL"
        }
        return result
    }
}
