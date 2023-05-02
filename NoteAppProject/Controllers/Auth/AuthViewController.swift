//
//  AuthViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 18/02/2023.
//

import UIKit

class AuthViewController: UIViewController {
    
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.text = "Loading..."
        label.numberOfLines = 2
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        self.setupUI()
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))

        NSLayoutConstraint.activate([
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
    }
    
    //MARK: - Selectors
    @objc private func didTapLogout(){
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutErrorAlert(on: self, with: error)
                return
            }
            if let scenceDeleage = self.view.window?.windowScene?.delegate as? SceneDelegate {
                scenceDeleage.checkAuthentication()
            }
        }
    }
}
