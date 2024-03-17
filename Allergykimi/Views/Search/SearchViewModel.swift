//
//  SearchViewModel.swift
//  Allergykimi
//
//  Created by 은서우 on 3/12/24.
//

import Foundation

class SearchViewModel {

    var inputViewDidLoadTrigger: Observable<String?> = Observable(nil)
    var outputData: Observable<[Item]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { text in
            guard let text else { return }
            self.fetchData(text: text)
        }
    }
    
    private func fetchData(text: String) {
        guard !text.isEmpty else { return }
        APIManager.shared.request(type: Products.self, api: .Products(query: text)) { data in
            self.outputData.value = data.body.items
        }
    }
    
}
