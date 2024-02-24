//
//  UserDefaults + Extensions.swift
//  RacingGame2024
//
//  Created by Марк Киричко on 13.01.2024.
//

import Foundation

extension UserDefaults {
    
    static func saveData<T: Encodable>(object: T, key: String, completion: @escaping()->Void) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.setValue(data, forKey: key)
            completion()
        } catch {
            print(error)
        }
    }
    
    static func loadData<T: Decodable>(type: T.Type, key: String)-> T? {
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let object = try JSONDecoder().decode(T.self, from: data)
                return object
            }
        } catch {
            print(error)
        }
        return nil
    }
}
