//
//  UIViewController+Extension.swift
//  Allergykimi
//
//  Created by 은서우 on 3/13/24.
//

import UIKit

extension UIViewController {
    
    // Alert 생성 함수
    func showAlert(title: String?, message: String?, buttonTitle: String?, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message:message,
                                      preferredStyle: .alert)
        
        let OK = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completionHandler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(OK)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    // 키보드 숨기기
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
