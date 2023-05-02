//
//  User.swift
//  NoteAppProject
//
//  Created by Guy Adler on 14/02/2023.
//

import Foundation

struct User: Codable {
    let id:Int64
    let first_name:String
    let last_name:String
    let email:String
    let gender:String
    let avatar:String
}

