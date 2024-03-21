//
//  MapViewModel.swift
//  Allergykimi
//
//  Created by 은서우 on 3/21/24.
//

import Foundation

class MapViewModel {
    
    var inputViewDidLoadTrigger: Observable<(String, String)> = Observable(("127.085156592737", "37.4881325624879"))
    var outputData: Observable<[PharmacyInfo]> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { data in
            self.fetchData(LON: data.0, LAT: data.1)
        }
    }
    
    private func fetchData(LON: String, LAT: String) {
        APIManager.shared.XMLrequest(api: .Pharmacy(LON: LON, LAT: LAT)) { xml in
            let pharmacy = Pharmacy(xml: xml).response.body.items.item
            self.outputData.value = pharmacy
        }
    }
    
}
