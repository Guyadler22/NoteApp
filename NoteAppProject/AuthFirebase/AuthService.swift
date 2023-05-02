//
//  AuthService.swift
//  NoteAppProject
//
//  Created by Guy Adler on 20/02/2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    
    public static let shared = AuthService()
    private init(){}
    
    /// A method to register the user
    /// -Parameters:
    ///  - userRequest:  The User information (email, password, username)
    ///  - Complition with two values...
    ///  - Bool: wasRegistred - Determines if the user was registred and save in the database currectly
    ///  - Error?: An optional error if firebase provides once
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?)->Void) {
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        //create user at authentication page at firebase
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false,error)
                return
            }
            //Grab the result user
            guard let resultUser = result?.user else {
                completion(false,nil)
                return
            }
            // Saving username and email at fireStore under "users" and then the userID
            let db = Firestore.firestore()
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false,error)
                        return
                    }
                    // if all done the completion is true -> user registred
                    completion(true,nil)
                }
        }
    }
    
    public func signInWithUserRequest(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(error)
                return
            }else{
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?)->Void){
        do{
            try Auth.auth().signOut()
            completion(nil)
        }catch let error{
            completion(error)
        }
        
    }
    
    public func forgotPassword(with email:String, completion: @escaping (Error?) -> Void ) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
        }
    }

}


