//
//  EntryViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 23/02/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

//This screen shows after select any note 
class EntryViewController: UIViewController {
        
    static let identifier = "EntryViewController"

    private let titleNote = CustomTextField(fieldType: .titleTextField)
    
    private let noteTextField = CustomTextField(fieldType: .noteTextField)
    
    public var completion: ((String, String) -> Void )?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleNote)
        view.addSubview(noteTextField)
        
        titleNote.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        setupUI()
    }
    
    private func setupUI(){
        titleNote.translatesAutoresizingMaskIntoConstraints = false
        noteTextField.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            
            self.titleNote.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor,constant: 10),
            self.titleNote.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            self.titleNote.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            self.titleNote.heightAnchor.constraint(equalToConstant: 50),
            
            self.noteTextField.topAnchor.constraint(equalTo: self.titleNote.bottomAnchor,constant: 10),
            self.noteTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            self.noteTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            self.noteTextField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            self.noteTextField.widthAnchor.constraint(equalToConstant: view.bounds.width),
            self.noteTextField.heightAnchor.constraint(equalToConstant: view.bounds.height),
        ])
        
    }
    
    //MARK:- Selectors
    
    @objc private func didTapSaveButton(){
     //check if the text if not empty,
        if let text = titleNote.text, !text.isEmpty, !noteTextField.text!.isEmpty {
            var noteToSave = Note(noteID: "", title: text, noteText: noteTextField.text ?? "", ownerID: Auth.auth().currentUser?.email ?? "")
            FirestoreServiceManager.shared.addNewNoteForTheUser(&noteToSave)
            
            navigationController?.popToRootViewController(animated: true)
            
        }else{
            AlertManager.TextEmptyError(on: self)
        }
        
    }
    
   

}
