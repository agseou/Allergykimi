//
//  SettingsViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/23/24.
//

import UIKit

final class SettingsViewController: BaseNavBarViewController {
    
    // MARK: - Components
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource: UITableViewDiffableDataSource<Section, String>!
    
    // MARK: - Properties
    lazy var repository: RealmRepository = {
        do {
            return try RealmRepository()
        } catch {
            fatalError("Failed to initialize the RealmRepository: \(error)")
        }
    }()
    let list = ["개인정보 처리 방침", "버전 정보", "처음부터 다시하기"]
    
    // MARK: - Life Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
        applyInitialSnapshot()
    }
    
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavLogoImage(true)
        isHiddenNavBarSettingsButton(true)
        setNavTitleText("설정")
    }
    
    override func setupDelegate() {
        super.setupDelegate()
        
        tableView.delegate = self
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func setConstraints() {
        super.setConstraints()
        tableView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView).inset(10)
            $0.horizontalEdges.equalTo(contentView).inset(5)
        }
    }
}

// MARK: - DataSource and ShanpShot
extension SettingsViewController {
    enum Section {
        case main
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            let cell: UITableViewCell
            if itemIdentifier == "버전 정보" {
                cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                cell.detailTextLabel?.text = "1.0.0"
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            }
            cell.textLabel?.text = itemIdentifier
            return cell
        }
        
    }
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}


extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let selectedItem = dataSource.itemIdentifier(for: indexPath) else { return }
        switch selectedItem {
        case "개인정보 처리 방침":
            // 개인정보 처리 방침 화면으로 이동
            let vc = WebViewController()
            vc.urlString = "https://maze-popcorn-285.notion.site/33564915fc81419ca26d009b0a296946?pvs=4"
            navigationController?.pushViewController(vc, animated: true)
        case "처음부터 다시하기":
            // 처음부터 다시하기 액션 실행
            showAlert(title: "처음부터 다시하시겠습니까?", message: "모든 데이터는 초기화됩니다.", buttonTitle: "확인") {
                UserDefaultsManager.shared.userState = false
                self.repository.deleteAllRealmData()
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = windowScene.delegate as? SceneDelegate {
                    sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: RegisterProfileViewController())
                    sceneDelegate.window?.makeKeyAndVisible()
                    UserDefaultsManager.shared.resetAllSettings()
                }
            }
        default:
            break
        }
    }
}
