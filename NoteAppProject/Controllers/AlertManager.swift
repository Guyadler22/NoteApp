//
//  AlertManager.swift
//  NoteAppProject
//
//  Created by Guy Adler on 20/02/2023.
//

import UIKit

class AlertManager {
    
    private static func showBasicAlert(on vc: UIViewController, title:String, message: String?){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            
            vc.present(alert, animated: true)
        }
    }
}

extension AlertManager {
    public static func showSeccesfullAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Registration was successfully", message: "You have successfully registered ")
    }
    
}


//MARK:- Show Validation alert
extension AlertManager {
    
    public static func showInvalidEmailAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Email", message: "Please enter a valid email.")
    }
    
    public static func showInvalidPasswordAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Password", message: "Please enter a valid Password. with one upercase one lower case and uniq character. minimum 8 digits.")
    }
    
    public static func showInvalidUsernameAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Invalid Username", message: "Please enter a valid Username.")
    }
    
}

//MARK:- Registration Errors
extension AlertManager {
    
    public static func showRegistrationErrorAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: nil)
    }
    
    public static func showRegistrationErrorAlert(on vc:UIViewController,with error:Error){
        self.showBasicAlert(on: vc, title: "Unknown Registration Error", message: "\(error.localizedDescription)")
    }
    
}

//MARK:- Log In Errors
extension AlertManager {
    
    public static func showSignInErrorAlert(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Error Signing In", message: nil)
    }
    
    public static func showSignInErrorAlert(on vc:UIViewController, with error:Error){
        self.showBasicAlert(on: vc, title: "Error Signing In", message: "\(error.localizedDescription)")
    }
    
}
//MARK:- Logout Errors
extension AlertManager {
    
    public static func showLogoutErrorAlert(on vc:UIViewController,with error:Error){
        self.showBasicAlert(on: vc, title: "Logout", message: "\(error.localizedDescription)")
    }
    
}
//MARK:- Forgot Password
extension AlertManager {
    
    public static func showPasswordResetSent(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Password Reset Sent", message: nil)
    }
    
    public static func showErrorSendingPasswordReset(on vc:UIViewController,with error:Error){
        self.showBasicAlert(on: vc, title: "Error Sending Password Reset", message: "\(error.localizedDescription)")
    }
    
}
//MARK:- Fetching User Errors
extension AlertManager {
    
    public static func showFetchingUserError(on vc:UIViewController,with error:Error){
        self.showBasicAlert(on: vc, title: "Error Fetching User", message: "\(error.localizedDescription)")
    }
    
    public static func showUnknownFetchingUserError(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Unknown Error Fetching User", message: nil)
    }
    
}
//MARK:- TextIsEmpty
extension AlertManager {
    
    public static func TextEmptyError(on vc:UIViewController){
        self.showBasicAlert(on: vc, title: "Error", message: "Please fill all the fields")
    }
    
}
