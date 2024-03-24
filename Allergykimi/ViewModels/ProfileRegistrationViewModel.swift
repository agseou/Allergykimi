//
//  ProfileRegistrationViewModel.swift
//  Allergykimi
//
//  Created by 은서우 on 3/23/24.
//

import Foundation

class ProfileRegistrationViewModel {
    
    
    var nickNameText: Observable<String?> = Observable(nil)
    var isValidateNickName: Observable<Bool> = Observable(false)
    var nicknameFeedbackText: Observable<String> = Observable("")
    
    var selectedAllergiesList: Observable<[Allergy]> = Observable([])
    
    var confirmedNickName: Observable<String> = Observable("")
    var confirmedAllergiesList: Observable<[Allergy]> = Observable([])
    
    init() {
        nickNameText.bind { text in
            self.validateNickName(text)
        }
    }
    
    private func validateNickName(_ text: String?) {
        // 1. 빈값
        guard let text = text, !text.isEmpty else { return }
        
        // 2. 글자수 및 특수문자 제한
        let regex = "^[가-힣A-Za-z0-9]{2,8}$"
        let nickNamePredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = nickNamePredicate.evaluate(with: text)
        isValidateNickName.value = isValid
        nicknameFeedbackText.value = isValid ? "가능한 닉네임입니다!" : "* 특수문자 제외, 2자 이상 9자 미만"
    }
}
