//
//  RealmRepository.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import Foundation
import RealmSwift

class RealmRepository {
    
    private let realm: Realm
    
    init() throws {
        self.realm = try Realm()
    }
    
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
            let productsToDelete = realm.objects(favoriteProduct.self).filter("prdlstReportNo == %@", prdlstReportNo)
            try realm.write {
                productsToDelete.forEach { product in
                    if !product.isInvalidated {
                        realm.delete(product)
                    }
                }
            }
        } catch {
            print("Error deleting product from favorites: \(error)")
        }
    }
    
    func addOrUpdateRecentProduct(_ newProduct: recentProduct) {
        do {
            try realm.write {
                // 이미 저장된 상품이 있는지 확인
                if let existingProductIndex = realm.objects(recentProduct.self).index(where: { $0.prdlstReportNo == newProduct.prdlstReportNo }) {
                    let existingProduct = realm.objects(recentProduct.self)[existingProductIndex]
                    realm.delete(existingProduct)
                }
                // 새 상품 추가
                realm.add(newProduct)

                // 상품 수 제한
                let recentProducts = realm.objects(recentProduct.self).sorted(byKeyPath: "dateAdded", ascending: false)
                if recentProducts.count > 10 {
                    // 10개 초과하는 상품 삭제
                    let productsToDelete = recentProducts.suffix(from: 10)
                    realm.delete(productsToDelete)
                }
            }
            print("Updated recent products list")
        } catch {
            print("Error updating recent products: \(error)")
        }
    }
    
}
