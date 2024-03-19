//
//  RegisterProfileViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

final class RegisterProfileViewController: BaseViewController {
    
    private let nickNameTextfield = UITextField()
    private let nextBtn = wideButton()
    
    override func configureHierarchy() {
        view.addSubview(nickNameTextfield)
        view.addSubview(nextBtn)
    }
    override func configureView() {
        super.configureView()
        nickNameTextfield.placeholder = "닉네임을 입력하세요!"
        nickNameTextfield.addTarget(self, action: #selector(changeNickNameTextfield), for: .editingChanged)
        
        nextBtn.isEnabled = false
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
    }
    
    @objc private func changeNickNameTextfield() {
        if let text = nickNameTextfield.text, !text.isEmpty {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
    }
    
    @objc private func tapNextBtn() {
        let vc = RegisterAllergyViewController()
        vc.myNickName = nickNameTextfield.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setConstraints() {
        nickNameTextfield.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

