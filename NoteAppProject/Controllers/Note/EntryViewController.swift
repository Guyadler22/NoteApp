//
//  EntryViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 23/02/2023.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

//Add note
class EntryViewController: UIViewController {
    
    static let identifier = "EntryViewController"
    
    private let titleNote = CustomTextField(fieldType: .titleTextField)
    
    private let noteTextField = CustomTextField(fieldType: .noteTextField)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleNote)
        view.addSubview(noteTextField)
        
        titleNote.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))
        
        setupUI()
    }
    
    // MARK:- Setup UI
    
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
        print("0")
        if let text = titleNote.text, !text.isEmpty, !noteTextField.text!.isEmpty {
            print("0.5")
            LocationManager.shared.getUserLocation { [weak self] location in
                DispatchQueue.main.async {
                    print("0.75")
                    guard let strongSelf = self else {
                        return
                    }
                    print("1")

                    var noteToSave = Note(noteID: "",title: text,noteText: strongSelf.noteTextField.text ?? "",
                                          addedIn: NoteLatLng(latitude: location.coordinate.latitude, longtitude:location.coordinate.longitude),
                                          ownerID: Auth.auth().currentUser?.email ?? "")
                    print("2")

                    FirestoreServiceManager.shared.addNewNoteForTheUser(&noteToSave)

                    print("3")

                    strongSelf.navigationController?.popToRootViewController(animated: true)

                }
            }

        }else{
            AlertManager.TextEmptyError(on: self)
        }
        
    }
    
}
