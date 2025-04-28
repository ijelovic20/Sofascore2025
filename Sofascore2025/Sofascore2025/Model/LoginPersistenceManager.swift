import Foundation

enum LoginPersistenceManager {
    private static let token = "token"
    private static let name = "name"

    static func saveData(token: String, name: String) {
        UserDefaults.standard.set(token, forKey: "token")
        UserDefaults.standard.set(name, forKey: "name")
    }

    static func getData() -> (token: String?, name: String?) {
        let token = UserDefaults.standard.string(forKey: "token")
        let name = UserDefaults.standard.string(forKey: "name")
        return (token, name)
    }

    static func clearData() {
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.removeObject(forKey: "name")
    }
}
