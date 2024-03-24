//
//  MapViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/17/24.
//

import UIKit
import NMapsMap
import Toast

class MapViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let nMapView = NMFMapView()
    private let myLocationBtn = {
        var config = UIButton.Configuration.filled()
        config.title = "현재 위치로"
        config.cornerStyle = .capsule
        let btn = UIButton()
        btn.configuration = config
        return btn
    }()
    
    // MARK: - Properties
    let viewModel = MapViewModel()
    let locationManager = CLLocationManager()
    private var floatingView = FloatingPharmacyInfoView()
    private var isFloatingViewPresented = false
    var list: [PharmacyInfo] = []
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationData()
        checkDeviceLocationAuthorization()
    }
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarBackButton(true)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubviews([nMapView, myLocationBtn, floatingView])
    }
    
    override func configureView() {
        super.configureView()
        
        locationManager.delegate = self
        
        nMapView.touchDelegate = self
        nMapView.allowsZooming = true
        nMapView.isNightModeEnabled = false
        nMapView.zoomLevel = 13
        nMapView.positionMode = .normal
        
        myLocationBtn.addTarget(self, action: #selector(tapMyLocationBtn), for: .touchUpInside)
        
        floatingView.isHidden = true
        floatingView.layer.shadowRadius = 1
        floatingView.layer.shadowColor = UIColor.gray.cgColor
        floatingView.layer.shadowOpacity = 0.6
        floatingView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    @objc private func tapMyLocationBtn() {
        updateCameraPosition()
    }
    
    func updateCameraPosition() {
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let camLocation = NMGLatLng(lat: latitude, lng: longitude)
            let cameraUpdate = NMFCameraUpdate(scrollTo: camLocation, zoomTo: 15)
            cameraUpdate.animation = .easeIn
            nMapView.moveCamera(cameraUpdate)
        } else {
            self.view.makeToast("사용자의 위치를 찾을 수 없습니다.")
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        nMapView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        myLocationBtn.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.horizontalEdges.equalTo(contentView).inset(30)
        }
        floatingView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalTo(contentView).inset(20)
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
        for (index, pharmacyInfo) in list.enumerated() {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: pharmacyInfo.latitude, lng: pharmacyInfo.longitude)
            marker.captionText = pharmacyInfo.dutyName
            marker.tag = UInt(index)
            marker.iconPerspectiveEnabled = true
            marker.touchHandler = {(overlay: NMFOverlay) -> Bool in
                print("touch")
                self.showFloatingView(tag: index)
                return true
            }
            marker.mapView = nMapView
        }
    }
    
    func deletMarker() {
        for mark in list {
            let latitude = mark.latitude
            let longitude = mark.longitude
            
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: latitude, lng: longitude)
            marker.mapView = nil
        }
    }
    
    private func showFloatingView(tag: Int) {
        guard tag >= 0 && tag < list.count else { return }
        floatingView.updateView(data: list[tag])
        floatingView.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.floatingView.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { _ in
            self.isFloatingViewPresented = true
        }
    }
    
    private func hideFloatingView() {
        UIView.animate(withDuration: 0.3) {
            self.floatingView.transform = CGAffineTransform(translationX: 0, y: 300)
        } completion: { _ in
            self.floatingView.isHidden = true
            self.isFloatingViewPresented = false
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
                authorization = self.locationManager.authorizationStatus
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
            showAlert(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정> 개인정보보호'에서 위치서비스를 켜주세요", buttonTitle: "설정으로 이동") {
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
            deletMarker()
            viewModel.inputViewDidLoadTrigger.value = ("\(coordinate.longitude)", "\(coordinate.latitude)")
            viewModel.outputData.bind { data in
                self.list = data
                self.setMarker()
            }
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

extension MapViewController: NMFMapViewTouchDelegate {
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        // 지도의 마커가 아닌 부분을 탭했을 때
        hideFloatingView()
    }
    
}
