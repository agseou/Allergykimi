//
//  RegisterAllergyViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/13/24.
//

import UIKit

class RegisterAllergyViewController: BaseViewController {

    let contentLabel = UILabel()
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        view.dataSource = self
        view.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        return view
    }()
    let nextBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "다음"
        let btn = UIButton()
        btn.configuration = config
        return btn
    }()
    var list: [Allergy] = [] {
        didSet { collectionView.reloadData() }
    }
    var infoLabel = UILabel()
    
    override func configureHierarchy() {
        view.addSubview(contentLabel)
        view.addSubview(infoLabel)
        view.addSubview(collectionView)
        view.addSubview(nextBtn)
    }
    
    override func configureView() {
        super.configureView()

        contentLabel.text = "나의 알러지 정보를\n등록해주세요"
        contentLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        infoLabel.text = "\(list.count)개의 알러지를 선택했어요!"
        
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
    }
    
    override func setConstraints() {
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    private func createLayout() -> UICollectionViewLayout {
       let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    @objc private func tapNextBtn() {
        let vc = CustomTabBarController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true) {
            UserDefaultsManager.shared.myAllergies = self.list
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterAllergyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Allergy.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        
        let data = Allergy.allCases[indexPath.row]
        cell.updateUI(data: data, list: list)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = Allergy.allCases[indexPath.row]
        if list.contains(data) {
            list.remove(at: list.firstIndex(of: data)!)
        } else {
            list.append(data)
        }
        infoLabel.text = "\(list.count)개의 알러지를 선택했어요!"
    }
    
}
