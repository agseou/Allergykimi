//
//  MapViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/17/24.
//

import UIKit
import NMapsMap

class MapViewController: BaseViewController, CLLocationManagerDelegate {
    
    let viewModel = MapViewModel()
    let locationManager = CLLocationManager()
    let nMapView = NMFMapView()
    var list: [PharmacyInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationData()
        viewModel.inputViewDidLoadTrigger.value = ("127.085156592737", "37.4881325624879")
        viewModel.outputData.bind { data in
            self.list = data
            self.setMarker()
        }
        //nMapView.forceRefresh()
    }
    
    override func configureHierarchy() {
        view.addSubview(nMapView)
    }
    
    override func configureView() {
        super.configureView()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        nMapView.allowsZooming = true
        nMapView.isNightModeEnabled = false
        nMapView.positionMode = .normal
    }
    
    override func setConstraints() {
        nMapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setLocationData() {
        // locationManager 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // 위도, 경도 가져오기
        let latitude = locationManager.location?.coordinate.latitude ?? 37.4881325624879
        let longitude = locationManager.location?.coordinate.longitude ?? 127.085156592737
        
        
        let camLocation = NMGLatLng(lat: latitude, lng: longitude)
        let cameraUpdate = NMFCameraUpdate(scrollTo: camLocation)
        nMapView.moveCamera(cameraUpdate)
    }
    
    // 마커 심기
    func setMarker() {
        for mark in list {
            let latitude = mark.latitude
            let longitude = mark.longitude
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: latitude, lng: longitude)
            marker.mapView = nMapView

        }
    }
    
}
