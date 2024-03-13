//
//  ViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import UIKit
import NMapsMap

class ViewController: BaseViewController {
    
    let mapView = NMFMapView()
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func configureView() {
        super.configureView()
      
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}
