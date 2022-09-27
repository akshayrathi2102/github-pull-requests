//
//  DatabaseManager.swift
//  iOSLearningApp
//
//  Created by Akshay Rathi on 17/09/22.
//

import Foundation

protocol DatabaseManager {
    var key: String { get }
    func getKey<T: Codable>()->T?
    func setKey<T: Codable>(object: T) -> Void
    func removeKey()
    func isPresent()-> Bool
}

public class DBManager: DatabaseManager {
    var key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public func getKey<T: Codable>() -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            print("Data not found in userDefaults")
            return nil
        }
        let userData = try? JSONDecoder().decode(T.self, from: data)
        return userData
    }
    
    public func setKey<T: Codable>(object: T) {
        if let data = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(data, forKey: key)
        } else {
            print("Could not encode data")
        }
    }
    
    public func removeKey() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    public func isPresent() -> Bool {
        if UserDefaults.standard.data(forKey: key) != nil {
            return true
        }
        else {
            return false
        }
    }
}
