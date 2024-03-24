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
    
    func fetchItem<T: Object>(ofType type: T.Type) -> Results<T> {
        print(realm.configuration.fileURL!)
        return realm.objects(T.self)
    }
    
    func countOfItems<T: Object>(ofType type: T.Type) -> Int {
        let results = realm.objects(T.self)
        return results.count
    }
    
    func deleteAllRealmData() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func isFavoriteProductExists(withPrdlstReportNo prdlstReportNo: String) -> Bool {
        return !realm.objects(favoriteProduct.self).filter("prdlstReportNo == %@", prdlstReportNo).isEmpty
    }
    func addFavoriteProduct(_ product: favoriteProduct) {
        do {
            try realm.write {
                realm.add(product)
            }
        } catch {
            print("Error adding product to favorites: \(error)")
        }
    }
    
    func deleteFavoriteProduct(withPrdlstReportNo prdlstReportNo: String) {
        do {
            if let productToDelete = realm.objects(favoriteProduct.self).filter("prdlstReportNo == %@", prdlstReportNo).first {
                try realm.write {
                    realm.delete(productToDelete)
                }
            }
        } catch {
            print("Error deleting product from favorites: \(error)")
        }
    }
    
    func addOrUpdateRecentProduct(_ newProduct: recentProduct) {
        do {
            try realm.write {
                // 중복 제거
                if let existingProduct = realm.objects(recentProduct.self).first(where: { $0.prdlstReportNo == newProduct.prdlstReportNo }) {
                    realm.delete(existingProduct)
                }
                
                // 새 상품 추가
                realm.add(newProduct, update: .modified)
                
                // 상품 수 제한
                let recentProducts = realm.objects(recentProduct.self).sorted(byKeyPath: "dateAdded", ascending: false)
                if recentProducts.count > 10 {
                    realm.delete(recentProducts.last!)
                }
            }
            print("Realm addOrUpdateRecentProduct")
        } catch {
            print(error)
        }
    }
    
}
