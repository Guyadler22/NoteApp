//
//  ViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 14/02/2023.
//

import UIKit

class NoteTableViewController: UIViewController {
    
    private let noteTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(noteTableView)

    }


}

