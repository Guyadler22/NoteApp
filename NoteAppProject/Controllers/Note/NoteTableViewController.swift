//
//  ViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 14/02/2023.
//

import UIKit
import SwipeCellKit
import FirebaseDatabase
import FirebaseAuth

class NoteTableViewController: UIViewController {
        
    static let identifier = "note"
    
     var notes:[Note] = [Note]()
    
    private let noteTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: NoteTableViewCell.identifier)
        return tableView
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "No Notes Yet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        title = "Notes"
        
        view.addSubview(noteTableView)
        view.addSubview(label)
        
        
        noteTableView.delegate = self
        noteTableView.dataSource = self
        
        //Hide tableView if empty
        noteTableView.isHidden = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(didTapAddButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(didTapLogOut))
        
        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getNotes()
    }
    
    private func getNotes() {
        let loggedInUserEmail = Auth.auth().currentUser?.email ?? ""
        print("Loggedn in usermail == \(loggedInUserEmail)")
        FirestoreServiceManager.shared.getNotesListAsPer(loggedInUserEmail) { [weak self] (status, message, notes) in
            guard let strongSelf = self else { return }
            if let notes = notes {
                strongSelf.notes = notes
                DispatchQueue.main.async {
                    strongSelf.noteTableView.reloadData()
                    if strongSelf.notes.count != 0 {
                        strongSelf.noteTableView.isHidden = false
                        
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noteTableView.frame = view.bounds
    }
    
    //MARK:- Selectors
    @objc private func didTapAddButton(){
        let vc = EntryViewController()
        
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "New Note"
        
        self.label.isHidden = true
        self.noteTableView.isHidden = false
        
        vc.completion = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.notes.append(Note(noteID: "", title: noteTitle, noteText: note))
            self.noteTableView.reloadData()
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLogOut(){
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

    //MARK:- UI Setup
    private func setupLabel(){
        
        NSLayoutConstraint.activate([
            
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
}

//MARK:- extensions

extension NoteTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath)as?
                NoteTableViewCell else {
            return UITableViewCell()
            
        }
        
        cell.delegate = self
        
        let notes = self.notes[indexPath.row]
    
        cell.setNoteDetails(notes)
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let note = self.notes[indexPath.row]

        let vc = NoteHandlerViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
        vc.note = note
        
        //Show note controller
//
//        let vc = EntryViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}

//Swipe to delete
extension NoteTableViewController: SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            
           let document = self.notes.remove(at: indexPath.row)
            
            FirestoreServiceManager.shared.deleteDataFromUser(document)
            
            self.noteTableView.reloadData()
            
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")

        return [deleteAction]
    }
    
}
