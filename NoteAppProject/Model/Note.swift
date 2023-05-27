//
//  Note.swift
//  NoteAppProject
//
//  Created by Guy Adler on 24/02/2023.
//

import Foundation


struct NoteLatLng : Codable {
    var latitude : Double
    var longtitude: Double
}

struct Note: Codable  {
    var noteID: String
    var title:String
    var noteText:String
    var addedIn : NoteLatLng
    var ownerID: String = ""
}

