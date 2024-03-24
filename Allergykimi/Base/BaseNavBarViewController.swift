//
//  NavigationBarViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/22/24.
//
/*
 [ Custom NavigationBar 적용하기 ]
 - 목적: Custom한 NavigationBar를 사용하기 위함
 - 방법: viewWillAppear에서 기존의 NavigationBar를 숨김, Layout을 이용한 눈속임 방법.
 
 */


import UIKit
import SnapKit

class NavigationBar: UIView {
    var backButton = UIButton()
    var logoImage = UIImageView()
    var title = UILabel()
    var settingsButton = UIButton()
}

protocol BaseNavBarViewControllerProtocol {
    var statusBar: UIView { get }
    var navigationBar: NavigationBar { get }
    var contentView: UIView { get }
    
    func setupNavigationBar()
    func setNavBarBackgroundColor(_ color: UIColor?)
    func setNavLogoImageColor(_ color: UIColor?)
    func isHiddenNavigationBar(_ hidden: Bool)
    func isHiddenNavLogoImage(_ hidden: Bool)
    func isHiddenNavBarBackButton(_ hidden: Bool)
    func isHiddenNavBarSettingsButton(_ hidden: Bool)
    func setNavTitleText(_ text: String?)
}

class BaseNavBarViewController: BaseViewController, BaseNavBarViewControllerProtocol {
    
    // MARK: - Components
    var statusBar = UIView() // 시간 & 배터리 떠 있는 스테이터스 바!
    var navigationBar = NavigationBar()
    var contentView = UIView()
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: - Functions
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubviews([statusBar, navigationBar, contentView])
        navigationBar.addSubviews([navigationBar.title,
                                   navigationBar.logoImage,
                                   navigationBar.backButton,
                                   navigationBar.settingsButton])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func configureView() {
        super.configureView()
        // navigationBar
        statusBar.backgroundColor = .white
        navigationBar.backgroundColor = .white
        
        // title
        navigationBar.title.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 17)
        
        // backButton
        navigationBar.backButton.setImage(UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), for: .normal)
        navigationBar.backButton.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        
        // logoImage
        navigationBar.logoImage.image = UIImage(resource: .allergykimiLogo).withRenderingMode(.alwaysTemplate)
        navigationBar.logoImage.contentMode = .scaleAspectFill
        
        // settingsButton
        navigationBar.settingsButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        navigationBar.settingsButton.addTarget(self, action: #selector(tapSettingsButton), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        // statusBar
        statusBar.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        // navigationBar
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        }
        // backButton ( 뒤로가기 버튼 )
        navigationBar.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        // logoImage ( 로고 이미지 )
        navigationBar.logoImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(50)
            $0.width.equalTo(60)
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
        }
        // settingsButton ( 설정 버튼 )
        navigationBar.settingsButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        // title ( 제목 )
        navigationBar.title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        // contentView
        contentView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom).offset(60)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - navigation Functions
    // 네비게이션 설정 func을 모아담을 함수
    func setupNavigationBar() { }
    
    func setNavBarBackgroundColor(_ color: UIColor?) {
        statusBar.backgroundColor = color
        navigationBar.backgroundColor = color
    }
    
    func setNavLogoImageColor(_ color: UIColor?) {
        navigationBar.logoImage.tintColor = color
        navigationBar.settingsButton.tintColor = color
    }
    
    //
    func isHiddenNavigationBar(_ hidden: Bool) {
        navigationBar.isHidden = hidden
    }
    
    func isHiddenNavLogoImage(_ hidden: Bool) {
        navigationBar.logoImage.isHidden = hidden
    }
    
    func isHiddenNavBarBackButton(_ hidden: Bool) {
        navigationBar.backButton.isHidden = hidden
    }
    
    func isHiddenNavBarSettingsButton(_ hidden: Bool) {
        navigationBar.settingsButton.isHidden = hidden
    }
    
    func setNavTitleText(_ text: String?) {
        navigationBar.title.text = text
    }
    
    // MARK: - Button Action Functions
    @objc private func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func tapSettingsButton() {
        let vc = SettingsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
