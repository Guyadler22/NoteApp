//
//  RegisterViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 18/02/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - UI Componenets
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    
    private let usernameField = CustomTextField(fieldType: .username)
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signUpButton = CustomButton(title: "Sign Up",hasBackground: true, fontSize: .big)
    private let signInButton = CustomButton(title: "Already have an account? Sign In.", fontSize: .med)
    
    private let termsTextField: UITextView = {
        let attributedString = NSMutableAttributedString(string: "By creating an account, you agree to our Terms & Condition and you acknowledge that you have read our Privacy Policy.")

        attributedString.addAttribute(.link, value: "terms://termsAndConditions",
                                      range: (attributedString.string as NSString).range(of: "Terms & Condition"))

        attributedString.addAttribute(.link, value: "privacy://privacyPolicy",
                                      range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let tv = UITextView()
        tv.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        tv.backgroundColor = .clear
        tv.attributedText = attributedString
        tv.textColor = .label
        tv.isSelectable = true
        tv.isEditable = false
        tv.delaysContentTouches = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.termsTextField.delegate = self

        view.addSubview(headerView)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(termsTextField)
        view.addSubview(emailField)
        
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
                
        self.setupUI()

    }
    
    //Disapear the navbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
    }
    //MARK:- UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        termsTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.usernameField.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 12),
            self.usernameField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor,constant: 22),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor,constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.85),
            
            self.signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor,constant: 22),
            self.signUpButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.85),
            
            self.termsTextField.topAnchor.constraint(equalTo: signUpButton.bottomAnchor,constant: 6),
            self.termsTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.termsTextField.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.85),
            
            self.signInButton.topAnchor.constraint(equalTo: termsTextField.bottomAnchor,constant: 11),
            self.signInButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.signInButton.heightAnchor.constraint(equalToConstant: 44),
            self.signInButton.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.85),

            
        ])
        
    }
    
    //MARK:- Selectors
    
    @objc private func didTapSignUp(){
        let registerUserRequset = RegisterUserRequest(
            username: self.usernameField.text ?? "",
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? "" )
        
        //username check
        if !Validator.isValidUsername(for: registerUserRequset.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        //email check
        if !Validator.isValidEmail(with: registerUserRequset.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        //password check
        if !Validator.isPasswordValid(for: registerUserRequset.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequset) { [weak self] wasRegisterd, error in
            guard let self = self else {return}
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            if wasRegisterd {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            }else{
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
        
}
    
    @objc private func didTapSignIn (){
        self.navigationController?.popToRootViewController(animated: true)
        print("didTapSignIn")

    }
}

extension RegisterViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "terms" {
            self.showWebViewrController(With: "https://policies.google.com/terms?hl=en-US")
            
        }else if URL.scheme == "privacy" {
            self.showWebViewrController(With: "https://policies.google.com/privacy?hl=en-US")
        }
        
        return true
    }
    
    private func showWebViewrController(With urlString:String){
        let vc = WebViewerViewController(with: urlString)
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        textView.delegate = nil
//        textView.selectedTextRange = nil
//        textView.delegate = self
//    }
    
}
