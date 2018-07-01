//
//  RealmManager.swift
//  Marvel
//
//  Created by Vinicius on 30/06/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    
    func save(character: Character) {
        var characters = [Character]()
        if let data = UserDefaults.standard.data(forKey: String(describing: Character.self)), let decoded = try? JSONDecoder().decode([Character].self, from: data) {
            characters = decoded
        }
        characters.append(character)
        UserDefaults.standard.set(try? JSONEncoder().encode(characters), forKey: String(describing: Character.self))
    }
    
    func loadCharacters() -> [Character]? {
        guard let data = UserDefaults.standard.data(forKey: String(describing: Character.self)), let decoded = try? JSONDecoder().decode([Character].self, from: data) else {
            return nil
        }
        return decoded
    }
    
    func remove(character: Character) {
        guard let characters = loadCharacters() else {
            return
        }
        let filtered = characters.filter { $0 != character }
        UserDefaults.standard.set(try? JSONEncoder().encode(filtered), forKey: String(describing: Character.self))
    }
}
