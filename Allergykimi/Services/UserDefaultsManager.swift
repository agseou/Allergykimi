//
//  UserDefaultsManager.swift
//  Allergykimi
//
//  Created by 은서우 on 3/14/24.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    enum UDKey: String {
        case userState
        case nickName
        case myAllergies
        case profileImagePath
    }
    
    let ud = UserDefaults.standard
    
    var userState: Bool {
        get { ud.bool(forKey: UDKey.userState.rawValue) }
        set { ud.setValue(newValue, forKey: UDKey.userState.rawValue) }
    }
    
    
    var nickName: String {
        get { ud.string(forKey: UDKey.nickName.rawValue) ?? "user" }
        set { ud.setValue(newValue, forKey: UDKey.nickName.rawValue) }
    }
    
    var myAllergies: [Allergy?] {
        get {
            guard let data = ud.data(forKey: UDKey.myAllergies.rawValue) else { return [] }
            return (try? JSONDecoder().decode([Allergy].self, from: data)) ?? []
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            ud.set(data, forKey: UDKey.myAllergies.rawValue)
        }
    }
    
    var profileImagePath: String? {
        get { ud.string(forKey: UDKey.profileImagePath.rawValue) }
        set { ud.setValue(newValue, forKey: UDKey.profileImagePath.rawValue) }
    }
}

extension UserDefaultsManager {
    
    func resetAllSettings() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        ImageStorageManager.shared.deleteImage()
    }
}
