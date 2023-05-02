//
//  InfoScreenView.swift
//  NoteAppProject
//
//  Created by Guy Adler on 16/02/2023.
//

import UIKit

class InfoScreenTableViewCell: UITableViewCell {
    
    static let identifier = "InfoScreenTableViewCell"
    
    private var stackView = UIStackView()
    
    private let Id:UILabel = {
        let Id = UILabel()
        Id.translatesAutoresizingMaskIntoConstraints = false
        Id.font = .systemFont(ofSize: 20, weight: .bold)
        Id.text = "Id"
        return Id
    }()
    
    private let email:UILabel = {
        let email = UILabel()
        email.translatesAutoresizingMaskIntoConstraints = false
        email.font = .systemFont(ofSize: 20, weight: .bold)
        email.text = "email"
        email.numberOfLines = 0

        return email
    }()
    
    private let gender:UILabel = {
        let gender = UILabel()
        gender.translatesAutoresizingMaskIntoConstraints = false
        gender.font = .systemFont(ofSize: 20, weight: .bold)
        gender.text = "gender"
        return gender
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.axis = .vertical
        stackView.addArrangedSubview(Id)
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(gender)
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let stackConstraint = [
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(stackConstraint)
    }

    func setDetail(_ user:User) {
        self.Id.text = "ID: \(user.id)"
        self.email.text = "Email: \(user.email)"
        self.gender.text = "Gender: \(user.gender)"
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

