//
//  MapViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/17/24.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController: BaseViewController {
    
    let locationManager = CLLocationManager()
    let mapView = NMFMapView()
    
    override func configureHierarchy() {
        view.addSubview(mapView)
    }
    
    override func configureView() {
        super.configureView()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        mapView.allowsZooming = true
        mapView.isNightModeEnabled = false
    }
    
    override func setConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    // 기기의 위치 권한을 확인하기
    func checkDeviceLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On 상태")
            locationManager.startUpdatingLocation()
            print(locationManager.location?.coordinate)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0))
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: locationManager.location?.coordinate.latitude ?? 0, lng: locationManager.location?.coordinate.longitude ?? 0)
            marker.mapView = mapView
        } else {
            print("위치 서비스 Off 상태")
        }
    }
}
