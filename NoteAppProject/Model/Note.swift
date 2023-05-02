//
//  Note.swift
//  NoteAppProject
//
//  Created by Guy Adler on 24/02/2023.
//

import Foundation

struct Note: Codable  {
    var noteID: String
    var title:String
    var noteText:String
    var ownerID: String = ""
}

