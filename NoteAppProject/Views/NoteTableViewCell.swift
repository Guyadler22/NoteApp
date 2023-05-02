//
//  NoteTableViewCell.swift
//  NoteAppProject
//
//  Created by Guy Adler on 23/02/2023.
//

import UIKit
import SwipeCellKit

class NoteTableViewCell: SwipeTableViewCell {
    
    static let identifier = "NoteTableViewCell"
    
    
    private let titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel:UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "subtitle"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        applyConstraints()

    }
            
    private func applyConstraints() {
        let titleLabelConstraint = [
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            self.titleLabel.widthAnchor.constraint(equalToConstant: 60 )
        ]
        
        let subTitleLabelConstraint = [
            self.subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: -20),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(subTitleLabelConstraint)
    
    }
    
     func setNoteDetails(_ note:Note) {
        
        self.titleLabel.text = note.title
        self.subTitleLabel.text = note.noteText

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

