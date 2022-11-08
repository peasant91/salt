//
//  PreferenceManager.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit

class PreferenceManager {
    
    static var shared: PreferenceManager {
        return PreferenceManager()
    }
    
    func save(_ key: String, _ value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func save(_ key: String, _ value: Int) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func save(_ key: String, _ value: Double) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func save(_ key: String, _ value: Float) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func save(_ key: String, _ value: Bool) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func load(_ key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
    
    func loadInt(_ key: String) -> Int? {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func loadDouble(_ key: String) -> Double? {
        return UserDefaults.standard.double(forKey: key)
    }
    
    func loadFloat(_ key: String) -> Float? {
        return UserDefaults.standard.float(forKey: key)
    }
    
    func loadBool(_ key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func delete(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func deleteAll() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
}
