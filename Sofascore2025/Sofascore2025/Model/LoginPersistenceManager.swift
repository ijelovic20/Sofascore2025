import Foundation

enum LoginPersistenceManager {
    private enum Keys {
        static let token = "token"
        static let name = "name"
    }

    static func saveData(token: String, name: String) {
        UserDefaults.standard.set(token, forKey: Keys.token)
        UserDefaults.standard.set(name, forKey: Keys.name)
    }

    static func getData() -> (token: String?, name: String?) {
        let token = UserDefaults.standard.string(forKey: Keys.token)
        let name = UserDefaults.standard.string(forKey: Keys.name)
        return (token, name)
    }

    static func clearData() {
        UserDefaults.standard.removeObject(forKey: Keys.token)
        UserDefaults.standard.removeObject(forKey: Keys.name)
        UserDefaults.standard.synchronize()
    }
}
