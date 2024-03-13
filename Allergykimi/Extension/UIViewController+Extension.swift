//
//  UIViewController+Extension.swift
//  Allergykimi
//
//  Created by 은서우 on 3/13/24.
//

import UIKit

extension UIViewController {
    
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
