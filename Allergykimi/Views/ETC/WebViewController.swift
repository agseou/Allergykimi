//
//  WebViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/20/24.
//

import UIKit
import WebKit

class WebViewController: BaseViewController {
    
    
    let webView = WKWebView()
    var urlString: String!
    
    override func configureHierarchy() {
        view.addSubview(webView)
    }
    
    override func configureView() {
        super.configureView()
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        webView.allowsBackForwardNavigationGestures = true
        
        webView.load(request)
    }
    
    override func setConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
