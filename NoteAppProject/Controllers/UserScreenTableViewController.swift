//
//  UserScreenTableViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 14/02/2023.
//

import UIKit

class UserScreenTableViewController: UIViewController {
    
    
    private var users:[User] = [User]()
    
    private let userTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UserScreenViewTableVIewCell.self, forCellReuseIdentifier: UserScreenViewTableVIewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(userTableView)
        userTableView.delegate = self
        userTableView.dataSource = self
        
        fetchData()
        
    }
    func fetchData(){
        ApiCaller.shared.request(url: nil) { result in
            switch result {
            case .success(let users):
                print("Users list == \(users)")
                self.users = users
                DispatchQueue.main.async {
                    self.userTableView.reloadData()
                }
            case .failure(let error):
                print("Error with API == \(error.localizedDescription)")
            }
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userTableView.frame = view.bounds
        
    }
    
    
}


extension UserScreenTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserScreenViewTableVIewCell.identifier, for: indexPath) as?
                UserScreenViewTableVIewCell else {
            return UITableViewCell()
        }
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 5
        
        let user = self.users[indexPath.row]
        
        cell.setUserDetailWith(user, model: user.avatar)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let infoScreenViewController = InfoScreenViewController()
        
        let user = users[indexPath.row]
        
        infoScreenViewController.user = user
        
        self.navigationController?.pushViewController(infoScreenViewController, animated: true)
        
    }
    
}



