//
//  RegisterAllergyViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/13/24.
//

import UIKit

final class RegisterAllergyViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let contentLabel = UILabel()
    private var infoLabel = UILabel()
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        view.dataSource = self
        view.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        return view
    }()
    private let nextBtn = WideButton(type: .next)
    private let noneBtn = WideButton(type: .none)
    private let prevBtn = WideButton(type: .prev)
    
    // MARK: - Properties
    private let viewModel: ProfileRegistrationViewModel
    private var filteredAllergies: [Allergy] {
        Allergy.allCases.filter { $0 != .none && $0 != .unknowned }
    }
    private var list: [Allergy] = [] {
        didSet { collectionView.reloadData() }
    }
    
    
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
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubviews([contentLabel, infoLabel, collectionView, nextBtn, noneBtn, prevBtn])
    }
    
    override func configureView() {
        super.configureView()
        
        contentLabel.text = "나의 알러지 정보를\n등록해주세요"
        contentLabel.numberOfLines = 0
        contentLabel.font = AllergykimiFonts.TmoneyRoundWind.regular(size: 24)
        
        infoLabel.text = "\(list.count)개의 알러지를 선택했어요!"
        
        nextBtn.addTarget(self, action: #selector(tapNextBtn), for: .touchUpInside)
        
        noneBtn.addTarget(self, action: #selector(tapNextBtn2), for: .touchUpInside)
        
        prevBtn.addTarget(self, action: #selector(tapPrevBtn), for: .touchUpInside)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView).offset(20)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(5)
            $0.leading.equalTo(contentView).offset(20)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(contentView)
        }
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(20)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(contentView).inset(20)
        }
        noneBtn.snp.makeConstraints {
            $0.top.equalTo(nextBtn.snp.bottom).offset(8)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(contentView).inset(20)
        }
        prevBtn.snp.makeConstraints {
            $0.top.equalTo(noneBtn.snp.bottom).offset(8)
            $0.height.equalTo(50)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.bottom.equalTo(contentView).inset(20)
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
        let vc = RegisterFinalInformationViewController(viewModel: viewModel)
        viewModel.confirmedAllergiesList.value = list
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func tapNextBtn2() {
        let vc = RegisterFinalInformationViewController(viewModel: viewModel)
        viewModel.confirmedAllergiesList.value = []
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func tapPrevBtn() {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterAllergyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredAllergies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        
        let data = filteredAllergies[indexPath.row]
        cell.updateUI(data: data, list: list)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = filteredAllergies[indexPath.row]
        if list.contains(data) {
            list.remove(at: list.firstIndex(of: data)!)
        } else {
            list.append(data)
        }
        infoLabel.text = "\(list.count)개의 알러지를 선택했어요!"
    }
    
}
