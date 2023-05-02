//
//  InfoScreenViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 17/02/2023.
//

import UIKit

class InfoScreenViewController: UIViewController {
    
    var user: User?
    
    private let infoTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(InfoScreenTableViewCell.self, forCellReuseIdentifier: InfoScreenTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(infoTableView)
        infoTableView.delegate = self
        infoTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoTableView.frame = view.bounds

    }
    
}
 
extension InfoScreenViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoScreenTableViewCell.identifier, for: indexPath) as?
                InfoScreenTableViewCell else {
            return UITableViewCell()
        }
        
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 5
        
        if let user = user {
            cell.setDetail(user)

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
