//
//  FirestoreServiceManager.swift
//  NoteAppProject
//
//  Created by Guy Adler on 09/03/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class FirestoreServiceManager{
    
    static let shared = FirestoreServiceManager()
    
    private init() {}
    
    internal let db = Firestore.firestore()
    
    func saveNoteForTheUser(_ note:Note) {
        do {
         
            try db.collection("users")
                .document(Auth.auth().currentUser!.uid)
                .collection("Notes")
                .document(note.noteID)
                .setData(from: note)
        } catch let error{
            print("Error == \(error.localizedDescription)")
        }
    }
    
    func addNewNoteForTheUser(_ note:inout Note) {
        note.noteID =   UUID.init().uuidString
        saveNoteForTheUser(note)
    }
    func getNotesListAsPer(_ ownerID:String ,_ completionHandler: @escaping (_ status:Bool, _ message:String, _ notes:[Note]?) -> Void) {
        let docRef =  db.collection("users")
            .document(Auth.auth().currentUser!.uid)
            .collection("Notes")
        docRef.getDocuments {  querySnapshot, error in
            
            if error == nil {
                if let querySnapshot = querySnapshot {
                    var notes = [Note]()
                    if querySnapshot.count != 0 {
                        for snapShot in querySnapshot.documents {
                            do {
                                let note = try snapShot.data(as: Note.self)
                                
                                notes.append(note)
                                
                            } catch let error {
                                print("Error parsing notes data = \(error)")
                            }
                        }
                        completionHandler(true, "", notes)
                    } else {
                        completionHandler(false, "No notes available.", nil)
                    }
                } else {
                    completionHandler(false,"Problem with server", nil)
                }
            } else {
                completionHandler(false, error?.localizedDescription ?? "Problem with server", nil)
            }
        }
    }
    
    
    //TODO: Update the note for spesific UserID
    
    
    //TODO: delete the note for spesific UserID
    
    func deleteDataFromUser(_ note:Note){
        db.collection("users")
            .document(Auth.auth().currentUser!.uid)
            .collection("Notes")
            .document("\(note.noteID)")
            .delete() { err in
            if let err = err {
                print("Error Removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
}
