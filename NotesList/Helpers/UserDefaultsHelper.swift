//
//  UserDefaultsHelper.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 11.08.2021.
//

import Foundation

class UserDefaultsHelper {
    
    private static let userDefaults = UserDefaults()
    
    static func saveLoginStatus(login: Bool) {
        userDefaults.setValue(login, forKey: UserKeys.userLoginStatusKey.rawValue)
    }
}
