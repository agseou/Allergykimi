//
//  ImageStorageManager.swift
//  Allergykimi
//
//  Created by 은서우 on 3/24/24.
//

import UIKit

class ImageStorageManager {
    static let shared = ImageStorageManager()
    
    private init() {}
    
    func saveImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        let filename = getDocumentsDirectory().appendingPathComponent("profileImage.jpg")
        try? data.write(to: filename)
        
        // UserDefaults 경로 저장
        UserDefaultsManager.shared.profileImagePath = filename.path
    }
    
    func loadImage() -> UIImage? {
        // UserDefault 이미지 경로 불러오기
        guard let imagePath = UserDefaultsManager.shared.profileImagePath,
              let image = UIImage(contentsOfFile: imagePath) else {
            return nil
        }
        return image
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func deleteImage() {
        guard let imagePath = UserDefaultsManager.shared.profileImagePath else { return }
        let fileURL = URL(fileURLWithPath: imagePath)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
            UserDefaultsManager.shared.profileImagePath = nil 
        } catch {
            print("이미지 삭제 중 오류 발생: \(error)")
        }
    }
}
