//
//  RegisterProfileViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit
import RealmSwift

final class RegisterProfileViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let contentLabel = UILabel()
    private let profileImage = ProfileView()
    private let nickNameTextfield = UITextField()
    private let nickNameTextfieldUnderLine = UIView()
    private let validNicknameLabel = UILabel()
    private let nextBtn = WideButton(type: .next)
    
    // MARK: - Properties
    private let viewModel = ProfileRegistrationViewModel()
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardNotifications()
        nickNameTextfield.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardNotifications()
    }
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarBackButton(true)
        isHiddenNavBarSettingsButton(true)
    }
    
    override func setupBind() {
        viewModel.isValidateNickName.bind { [weak self] isActive in
            self?.nextBtn.isEnabled = isActive
            self?.nickNameTextfieldUnderLine.backgroundColor = isActive ? .accent : .gray
            
        }
        viewModel.nicknameFeedbackText.bind { [weak self] text in
            self?.validNicknameLabel.text = text
        }
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubviews([contentLabel, profileImage, nickNameTextfield, nickNameTextfieldUnderLine, validNicknameLabel, nextBtn])
    }
    
    override func configureView() {
        super.configureView()
        // contentLabel
        contentLabel.text = "프로필을 등록해주세요."
        contentLabel.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 24)
        
        // profileImage
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageButtonTapped))
        profileImage.addGestureRecognizer(tapGesture)
        
        // nickNameTextfieldUnderLine
        nickNameTextfieldUnderLine.backgroundColor = .gray
        
        // nickNameTextfield
        nickNameTextfield.placeholder = "닉네임을 입력하세요!"
        nickNameTextfield.addTarget(self, action: #selector(changeNickNameTextfield), for: .editingChanged)
        
        // nickNameTextfield
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
    }
    
    @objc private func changeNickNameTextfield() {
        viewModel.nickNameText.value = nickNameTextfield.text
    }
    
    @objc private func tapNextBtn() {
        let vc = RegisterAllergyViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        contentLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalToSuperview().offset(10)
        }
        profileImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        nickNameTextfield.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.top.equalTo(profileImage.snp.bottom).offset(30)
        }
        nickNameTextfieldUnderLine.snp.makeConstraints {
            $0.horizontalEdges.equalTo(nickNameTextfield)
            $0.height.equalTo(2)
            $0.top.equalTo(nickNameTextfield.snp.bottom).offset(5)
        }
        validNicknameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(nickNameTextfield)
            $0.top.equalTo(nickNameTextfieldUnderLine.snp.bottom).offset(2)
            $0.height.equalTo(40)
        }
        nextBtn.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

extension RegisterProfileViewController {
   
        
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                self.nextBtn.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().inset(keyboardSize.height - 10)
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.nextBtn.snp.updateConstraints { make in
                make.bottom.equalToSuperview().inset(10) // 기본값으로 재설정
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension RegisterProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc private func profileImageButtonTapped() {
        let actionSheet = UIAlertController(title: "프로필 사진 선택", message: "사진을 가져올 방법을 선택하세요.", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
                self.presentImagePicker(sourceType: .camera)
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "앨범", style: .default, handler: { _ in
            self.presentImagePicker(sourceType: .photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(actionSheet, animated: true)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true)
    }
    
    // UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[.originalImage] as? UIImage {
            // 선택된 이미지를 프로필 이미지 버튼의 배경으로 설정
            profileImage.profileImage.image = chosenImage
            ImageStorageManager.shared.saveImage(image: chosenImage)
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
