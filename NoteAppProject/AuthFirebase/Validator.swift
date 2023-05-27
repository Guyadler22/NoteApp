//
//  Validator.swift
//  NoteAppProject
//
//  Created by Guy Adler on 23/02/2023.
//

import Foundation

class Validator {
    
    static let validator = Validator()
    
    static func isValidEmail(with email:String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidUsername(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegEx = "\\w{4,24}"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }

    static func isPasswordValid(for password:String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,32}$"
    /*   At least one lower case (?=.*?[a-z])
         At least one upper case(?=.*?[A-Z])
         At least one digit, (?=.*?[0-9])
         At least one special character, (?=.*?[#?!@$%^&*-])
         Minimum eight in length .{8,} (with the anchors)
    */
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

}
