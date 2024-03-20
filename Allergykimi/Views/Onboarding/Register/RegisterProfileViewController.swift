//
//  RegisterProfileViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

final class RegisterProfileViewController: BaseViewController {
    
    private let contentLabel = UILabel()
    private let nickNameTextfield = UITextField()
    private let nickNameTextfieldUnderLine = UIView()
    private let nextBtn = wideButton()
    
    override func configureHierarchy() {
        view.addSubview(contentLabel)
        view.addSubview(nickNameTextfield)
        view.addSubview(nickNameTextfieldUnderLine)
        view.addSubview(nextBtn)
    }
    override func configureView() {
        super.configureView()
        contentLabel.text = "이름을 등록해주세요"
        contentLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        nickNameTextfieldUnderLine.backgroundColor = .gray
        
        nickNameTextfield.placeholder = "닉네임을 입력하세요!"
        nickNameTextfield.addTarget(self, action: #selector(changeNickNameTextfield), for: .editingChanged)
        
        nextBtn.isEnabled = false
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
    }
    
    @objc private func changeNickNameTextfield() {
        if let text = nickNameTextfield.text, !text.isEmpty {
            nextBtn.isEnabled = true
            nickNameTextfieldUnderLine.backgroundColor = .accent
        } else {
            nextBtn.isEnabled = false
            nickNameTextfieldUnderLine.backgroundColor = .gray
        }
    }
    
    @objc private func tapNextBtn() {
        let vc = RegisterAllergyViewController()
        vc.myNickName = nickNameTextfield.text
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        nickNameTextfield.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
        }
        nickNameTextfieldUnderLine.snp.makeConstraints {
            $0.horizontalEdges.equalTo(nickNameTextfield)
            $0.height.equalTo(2)
            $0.top.equalTo(nickNameTextfield.snp.bottom).offset(5)
        }
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}

