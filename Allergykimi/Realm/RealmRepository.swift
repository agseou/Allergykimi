//
//  RealmRepository.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import Foundation
import RealmSwift

class RealmRepository {
    
    private let realm = try! Realm()
    
    func createItem<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.add(item)
                print("Realm create")
            }
        } catch {
            print(error)
        }
        print(realm.configuration.fileURL!)
    }
}
