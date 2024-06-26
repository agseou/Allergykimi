//
//  BottomSheetViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/19/24.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func didDismissWithFilteredAllergies(_ allergies: [Allergy])
}

class FilterBottomSheetViewController: BaseViewController {
    
    // MARK: - Components
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "TagCollectionViewCell")
        return view
    }()
    
    // MARK: - Properties
    weak var delegate: BottomSheetDelegate?
    var filteredALLAllergies: [Allergy] {
        Allergy.allCases.filter { $0 != .none && $0 != .unknowned }
    }
    var filiterAllergies: [Allergy] = [] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Life Cycle Functions
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didDismissWithFilteredAllergies(filiterAllergies)
    }
    
    
    // MARK: - Functions
    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    override func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(5)
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
    
}

// MARK: - CollectionView Delegate
extension FilterBottomSheetViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredALLAllergies.count
    }
    
    // cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        
        let data = filteredALLAllergies[indexPath.row]
        cell.updateUI(data: data, list: filiterAllergies)
        
        return cell
    }
    
    // didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = filteredALLAllergies[indexPath.row]
        if filiterAllergies.contains(data) {
            filiterAllergies.remove(at: filiterAllergies.firstIndex(of: data)!)
        } else {
            filiterAllergies.append(data)
        }
    }
    
}

