//
//  RegisterFinalInformationViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

class RegisterFinalInformationViewController: BaseViewController {
    
    private let nextBtn = wideButton()
    let nickNameLabel = UILabel()
    let myAllergyLabel = UILabel()
    
    var myNickName: String?
    var myAllergiesList: [Allergy] = []
    
    override func configureHierarchy() {
        view.addSubview(nickNameLabel)
        view.addSubview(myAllergyLabel)
        view.addSubview(nextBtn)
    }
    override func configureView() {
        super.configureView()
        
        nickNameLabel.text = "\(myNickName ?? "User")님"
        nickNameLabel.textColor = .accent
        nickNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        if !myAllergiesList.isEmpty {
            let allergyNames = myAllergiesList.map { "#" + $0.name.first! }.joined(separator: ", ")
            myAllergyLabel.text = "등록한 알러지는\n" + allergyNames + "\n 이 맞으시나요?"
        } else {
            myAllergyLabel.text = "알러지를 등록하지 않은게 맞으시나요?"
            myAllergyLabel.textColor = .red
        }
        myAllergyLabel.font = .systemFont(ofSize: 20, weight: .bold)
       
        myAllergyLabel.numberOfLines = 0
        myAllergyLabel.textAlignment = .center
        myAllergyLabel.lineBreakMode = .byWordWrapping
        
        nextBtn.configuration?.title = "완료"
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
    }
    
    @objc func tapNextBtn() {
        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
            UserDefaultsManager.shared.myAllergies = self.myAllergiesList
            UserDefaultsManager.shared.nickName = self.myNickName ?? "User"
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func setConstraints() {
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        myAllergyLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    
}
