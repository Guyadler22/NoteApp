//
//  WebViewerViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 19/02/2023.
//

import UIKit
import WebKit

class WebViewerViewController: UIViewController {
    
    private let webView = WKWebView()
    
    private let urlString: String
    
    init(with urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(webView)
        
        setupUI()

        guard let url = URL(string: urlString) else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.webView.load(URLRequest(url: url))
    }
    
    private func setupUI(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        
        ])
        
    }

    @objc private func didTapDone(){
        self.dismiss(animated: true, completion: nil)
    }

}
