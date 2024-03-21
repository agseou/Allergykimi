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
            self.fetchData(pages: "1", prdname: text)
        }
    }
    
    private func fetchData(pages: String, prdname: String) {
        guard !prdname.isEmpty else { return }
        APIManager.shared.request(type: Products.self, api: .Products(pages: pages, prdname: prdname, prdkind: "", prdlstReportNo: "")) { data in
            self.outputData.value = data.body.items
        }
    }
    
}
