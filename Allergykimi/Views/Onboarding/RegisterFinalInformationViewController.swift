//
//  RegisterFinalInformationViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

class RegisterFinalInformationViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let nextBtn = wideButton()
    private let nickNameLabel = UILabel()
    private let myAllergyLabel = UILabel()
    private let prevBtn = wideButton()
    
    // MARK: - Properties
    private let viewModel: ProfileRegistrationViewModel
    private var myAllergiesList: [Allergy] = []
    
    // MARK: - Functions
    init(viewModel: ProfileRegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarBackButton(true)
        isHiddenNavBarSettingsButton(true)
    }
    
    override func setupBind() {
        super.setupBind()
        viewModel.nickNameText.bind { [weak self] text in
            self?.nickNameLabel.text = text
        }
        viewModel.confirmedAllergiesList.bind { [weak self] list in
            self?.myAllergiesList = list
        }
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubviews([nickNameLabel, myAllergyLabel, nextBtn, prevBtn])
    }
    override func configureView() {
        super.configureView()
        
        nickNameLabel.textColor = .accent
        nickNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        if !myAllergiesList.isEmpty {
            let allergyNames = myAllergiesList.map { "#" + $0.name.first! }.joined(separator: ", ")
            myAllergyLabel.text = "등록한 알러지는\n" + allergyNames + "\n 이 맞으시나요?"
        } else {
            myAllergyLabel.text = "알러지를 등록하지 않은게 맞으시나요?"
            myAllergyLabel.textColor = .red
        }
        
        myAllergyLabel.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 20)
        myAllergyLabel.numberOfLines = 0
        myAllergyLabel.textAlignment = .center
        myAllergyLabel.lineBreakMode = .byWordWrapping
        
        nextBtn.configuration?.title = "완료"
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
        
        prevBtn.configuration?.title = "이전"
        prevBtn.configuration?.baseBackgroundColor = .gray
        prevBtn.addTarget(self, action: #selector(tapPrevBtn), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(50)
            $0.centerX.equalTo(contentView)
        }
        myAllergyLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(contentView).inset(20)
        }
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(contentView).inset(20)
        }
        prevBtn.snp.makeConstraints {
            $0.top.equalTo(nextBtn.snp.bottom).offset(8)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView).inset(20)
        }
    }
    
    
    @objc func tapNextBtn() {
        UserDefaultsManager.shared.myAllergies = viewModel.confirmedAllergiesList.value
        UserDefaultsManager.shared.nickName = viewModel.nickNameText.value ?? "Kimi"
        UserDefaultsManager.shared.userState = true
        let vc = BaseTabBarController()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = vc
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @objc private func tapPrevBtn() {
        navigationController?.popViewController(animated: true)
    }
    
}
