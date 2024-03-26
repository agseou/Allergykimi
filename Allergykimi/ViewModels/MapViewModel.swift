//
//  MapViewModel.swift
//  Allergykimi
//
//  Created by 은서우 on 3/21/24.
//

import Foundation

class MapViewModel {
    
    var inputViewDidLoadTrigger: Observable<(String?, String?)> = Observable((nil, nil))
    var outputData: Observable<[PharmacyInfo]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { data in
            guard let LON = data.0, let LAT = data.1 else { return }
            self.fetchData(LON: LON, LAT: LAT)
        }
    }
    
    private func fetchData(LON: String, LAT: String) {
        APIManager.shared.XMLrequest(api: .Pharmacy(LON: LON, LAT: LAT)) { xml in
            let pharmacy = Pharmacy(xml: xml).response.body.items.item
            self.outputData.value = pharmacy
        }
    }
    
}
