//
//  WebViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit
import WebKit

class WebViewController: BaseNavBarViewController {
    
    // MARK: - Components
    let webView = WKWebView()
    
    // MARK: - Properties
    var urlString: String!
    
    // MARK: - Functions
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        isHiddenNavBarSettingsButton(true)
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        contentView.addSubview(webView)
    }
    
    override func configureView() {
        super.configureView()
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.allowsBackForwardNavigationGestures = true
        webView.load(request)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
}
