//
//  UserScreenViewTableVIewCell.swift
//  NoteAppProject
//
//  Created by Guy Adler on 14/02/2023.
//

import UIKit
import Kingfisher

class UserScreenViewTableVIewCell: UITableViewCell {

    static let identifier = "UserScreenViewTableVIewCell"
        
    private let avatar : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "lightbulb.fill")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let nameLabel:UILabel = {
       let first_name = UILabel()
        first_name.translatesAutoresizingMaskIntoConstraints = false
        first_name.font = .systemFont(ofSize: 20, weight: .bold)
        first_name.text = "first name"
        return first_name
    }()
    
    private let lastNameLabel:UILabel = {
       let last_name = UILabel()
        last_name.translatesAutoresizingMaskIntoConstraints = false
        last_name.font = .systemFont(ofSize: 20, weight: .bold)
        last_name.text = "last name"
        return last_name
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(avatar)
        contentView.addSubview(nameLabel)
        contentView.addSubview(lastNameLabel)
        
        applyConstraints()

    }
     
    private func applyConstraints() {
        let avatarImageConstraint = [
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            avatar.widthAnchor.constraint(equalToConstant: 100 )
        ]
        
        let nameLabelConstraint = [
            nameLabel.leadingAnchor.constraint(equalTo: avatar.trailingAnchor,constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let lastNameLabelConstarint = [
            lastNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            lastNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(avatarImageConstraint)
        NSLayoutConstraint.activate(nameLabelConstraint)
        NSLayoutConstraint.activate(lastNameLabelConstarint)
    }
    
    func setUserDetailWith(_ user: User, model: String){
        self.nameLabel.text  = user.first_name
        self.lastNameLabel.text = user.last_name
    
        guard let url = URL(string: "https://robohash.org/\(model)") else {
            return
        }
        self.avatar.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
}
