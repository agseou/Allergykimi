//
//  ProductDetailViewModel.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import Foundation

class ProductDetailViewModel {
    
    var inputViewDidLoadTrigger: Observable<String?> = Observable(nil)
    var outputData: Observable<ItemInfo?> = Observable(nil)
    
    init() {
        inputViewDidLoadTrigger.bind { text in
            guard let text else { return }
            self.fetchData(prdlstReportNo: text)
        }
    }
    
    private func fetchData(prdlstReportNo: String) {
        guard !prdlstReportNo.isEmpty else { return }
        APIManager.shared.request(type: Products.self, api: .Products(pages: "1", prdname: "", prdkind: "", prdlstReportNo: prdlstReportNo)) { data in
            self.outputData.value = data.body.items[0].item
        }
    }
    
}
