//
//  NoteTableViewCell.swift
//  NoteAppProject
//
//  Created by Guy Adler on 23/02/2023.
//

import UIKit
import SwipeCellKit

protocol NoteTableViewCellDelegate : AnyObject {
    func onShowNoteLocation(note: Note)
}


class NoteTableViewCell: SwipeTableViewCell {
    
    static let identifier = "NoteTableViewCell"

    lazy var noteCellDelegate: NoteTableViewCellDelegate? = nil

    var note: Note?
    
    private let titleLabel:UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Title"
        label.numberOfLines = 1
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
    
    private let mapBTN:UIButton = {
        let mapBTN = UIButton()
        mapBTN.setImage(UIImage(systemName: "mappin"), for: .normal)
        mapBTN.tintColor = .systemRed
        mapBTN.translatesAutoresizingMaskIntoConstraints = false
        return mapBTN
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(mapBTN)
        
        applyConstraints()
        
        

        mapBTN.addAction(UIAction(handler: {[weak self] (act) in
            self?.didTapMapBTN()
        }), for: .touchUpInside)

    }
            
    private func applyConstraints() {
        let titleLabelConstraint = [
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            self.titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width )
        ]
        
        let subTitleLabelConstraint = [
            self.subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: -20),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            
        ]
        
        let mapBTNConstarint = [
            self.mapBTN.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 32),
            self.mapBTN.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -32),
            self.mapBTN.widthAnchor.constraint(equalToConstant: 25),
            self.mapBTN.heightAnchor.constraint(equalToConstant: 25),
//            self.mapBTN.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 25),
            
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraint)
        NSLayoutConstraint.activate(subTitleLabelConstraint)
        NSLayoutConstraint.activate(mapBTNConstarint)
    
    }

    
    func setNoteDetails(_ note:Note) {
        self.titleLabel.text = note.title
        self.subTitleLabel.text = note.noteText
        self.note = note
    }
  
    func setCellNoteDelegate(_ delegate: NoteTableViewCellDelegate) {
        noteCellDelegate = delegate
    }
    
    func didTapMapBTN(){
        guard let note = note else {
            print("Note is null")
            return
        }
        noteCellDelegate?.onShowNoteLocation(note: note)
        print("clicked")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

