//
//  NoteHandlerViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 26/02/2023.
//

import UIKit

class NoteHandlerViewController: UIViewController {
    

    public var note:Note?

    public var completion: ((String) -> Void )?
    
    private let titleLabel:UILabel = {
        let label = UILabel()
         label.textColor = .secondaryLabel
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 24, weight: .medium)
         label.text = "Error"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private let textView:UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.font = .systemFont(ofSize: 19, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
       return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(titleLabel)
        view.addSubview(textView)

        titleLabel.text = note?.title
        textView.text = note?.noteText
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSaveButton))

        
        activeConstraints()
    }
    
    private func activeConstraints(){

        NSLayoutConstraint.activate([
            
            self.titleLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor,constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.textView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 10),
            self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
            self.textView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            self.textView.heightAnchor.constraint(equalToConstant: view.bounds.height),
        ])
        
    }
    
    //MARK:- Selectors
    
    @objc private func didTapSaveButton(){
        note!.noteText =  self.textView.text
        FirestoreServiceManager.shared.saveNoteForTheUser(note!)
        navigationController?.popToRootViewController(animated: true)
    }
}
