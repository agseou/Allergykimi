//
//  MapViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/17/24.
//

import UIKit
import NMapsMap

class MapViewController: BaseViewController {
    
    let viewModel = MapViewModel()
    let locationManager = CLLocationManager()
    let nMapView = NMFMapView()
    private let myLocationBtn = {
        var config = UIButton.Configuration.filled()
        config.title = "현재 위치에서 업데이트"
        config.cornerStyle = .capsule
        let btn = UIButton()
        btn.configuration = config
        return btn
    }()
    var list: [PharmacyInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationData()
        viewModel.inputViewDidLoadTrigger.value = ("127.085156592737", "37.4881325624879")
        viewModel.outputData.bind { data in
            self.list = data
            self.setMarker()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(nMapView)
        view.addSubview(myLocationBtn)
    }
    
    override func configureView() {
        super.configureView()
        myLocationBtn.addTarget(self, action: #selector(tapMyLocationBtn), for: .touchUpInside)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        nMapView.allowsZooming = true
        nMapView.isNightModeEnabled = false
        nMapView.positionMode = .normal
        
    }
    
    @objc private func tapMyLocationBtn() {
       // updateCameraPosition()
    }
    
    override func setConstraints() {
        nMapView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        myLocationBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
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

extension MapViewController {
    // 기기의 위치 권한을 확인하기
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                //현재 사용자의 위치 권한 상태 확인
                let authorization: CLAuthorizationStatus
                if #available(iOS 14.0, *) { //iOS 14 이상부터
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없어요.")
            }
        }
    }
    
    // "현재" 기기의 위치 권한을 확인하기
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        
        switch status {
            // 권한 허용에 접근 안함
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            self.locationManager.startUpdatingLocation()
            showAlert(title: "위치정보이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정> 개인정보보호'에서 위치서비스를 켜주세요", buttonTitle: "설정으로 이동") {
                if let setting = URL(string: UIApplication.openSettingsURLString){
                    UIApplication.shared.open(setting)
                } else {
                    print("설정으로 가주세요")
                }
            }
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default :
            print("error")
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 가져오기 -> [성공]
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            let camLocation = NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude)
            let cameraUpdate = NMFCameraUpdate(scrollTo: camLocation)
            nMapView.moveCamera(cameraUpdate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 가져오기 -> [실패]
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("실패")
    }
    
    // 사용자 권한 상태가 바뀔 때를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
}
