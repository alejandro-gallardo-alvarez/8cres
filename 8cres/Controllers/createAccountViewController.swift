//
//  createAccountViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/2/21.
//
import UIKit
import FirebaseAuth
import Firebase

class CreateAccountViewController: UIViewController {
    
    let createAccountLabel = UILabel()
    let emailTextField = UITextField()
    let enterPassTextField = UITextField()
    let reEnterPassTextfield = UITextField()
    let createAccount = UIButton()
    let cancelAccount = UIButton()
//    private let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        createAccountPlace()
        emailTextPlace()
        enterPasswrd()
        reEnterPasswrd()
        creatAccntFun()
        cancelAccntFun()
    }
    
    func createAccountPlace() {
        createAccountLabel.textAlignment = .center
        createAccountLabel.text = "Create Account"
        self.view.addSubview(createAccountLabel)
        // added constraints
        createAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            createAccountLabel.widthAnchor.constraint(equalToConstant: 150),
            createAccountLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func emailTextPlace() {
        emailTextField.textColor = UIColor.black
        emailTextField.textAlignment = .center
        emailTextField.placeholder = "Email"
        emailTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        self.view.addSubview(emailTextField)
        // added constraints
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            emailTextField.widthAnchor.constraint(equalToConstant: 260),
            emailTextField.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    
    func enterPasswrd() {
        enterPassTextField.textColor = UIColor.black
        enterPassTextField.textAlignment = .center
        enterPassTextField.placeholder = "Enter password"
        enterPassTextField.layer.backgroundColor = UIColor.lightGray.cgColor
        enterPassTextField.layer.borderColor = UIColor.black.cgColor
        enterPassTextField.isSecureTextEntry = true
        self.view.addSubview(enterPassTextField)
        // added constraints
        enterPassTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterPassTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterPassTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            enterPassTextField.widthAnchor.constraint(equalToConstant: 260),
            enterPassTextField.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func reEnterPasswrd () {
        reEnterPassTextfield.textColor = UIColor.black
        reEnterPassTextfield.textAlignment = .center
        reEnterPassTextfield.placeholder = "Re-enter password"
        reEnterPassTextfield.layer.backgroundColor = UIColor.lightGray.cgColor
        reEnterPassTextfield.isSecureTextEntry = true
        self.view.addSubview(reEnterPassTextfield)
        // added constraints
        reEnterPassTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reEnterPassTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reEnterPassTextfield.topAnchor.constraint(equalTo: enterPassTextField.bottomAnchor, constant: 15),
            reEnterPassTextfield.widthAnchor.constraint(equalToConstant: 260),
            reEnterPassTextfield.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func creatAccntFun() {
        createAccount.setTitle("Create Account", for: [])
        createAccount.titleLabel?.font = UIFont(name:"FontAwesome", size: 35)
        createAccount.addTarget(self, action:#selector(createAccountButton), for:.touchUpInside)
        createAccount.layer.backgroundColor = UIColor.lightGray.cgColor
        createAccount.setTitleColor(UIColor.black, for: .normal)
         self.view.addSubview(createAccount)
        // added constraints
        createAccount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccount.topAnchor.constraint(equalTo: reEnterPassTextfield.bottomAnchor, constant: 50),
            createAccount.widthAnchor.constraint(equalToConstant: 260),
            createAccount.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword (_ password: String) -> Bool{
       let passwordRegEx = "[A-Z0-9a-z._%+-~!@#$^&*?]{6,}"
        
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    func matchingPasswordsFunction (_ password: String, _ rePassword: String) ->Bool {
        if enterPassTextField.text != reEnterPassTextfield.text {
            return false
        }
        return true
    }
    @objc func createAccountButton() {
        if isValidEmail(emailTextField.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "The email adress is badly formatted.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
        if isValidPassword(enterPassTextField.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Password must contain atleast 6 characters",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
        if matchingPasswordsFunction(enterPassTextField.text!, reEnterPassTextfield.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Passwords do not match.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
        if isValidEmail(emailTextField.text!) == true && matchingPasswordsFunction(enterPassTextField.text!, reEnterPassTextfield.text!) == true {
            if let email = emailTextField.text, let password = enterPassTextField.text {
                Auth.auth().createUser(withEmail:email,password:password) {authResult, error in
                    if let e = error {
                        let alert = UIAlertController(title: "Sign In Failed",
                                              message: e.localizedDescription,
                                              preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Success",
                                              message: "Account has been created.",
                                              preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                            self.dismiss(animated: true, completion: {
                                UIApplication.shared.windows.first!.rootViewController = NewUserViewController()
                            })
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func cancelAccntFun() {
        cancelAccount.setTitle("Cancel", for: [])
        cancelAccount.titleLabel?.font = UIFont(name:"FontAwesome", size: 35)
        cancelAccount.addTarget(self, action:#selector(cancelAccountButton), for:.touchUpInside)
        cancelAccount.layer.backgroundColor = UIColor.lightGray.cgColor
        cancelAccount.setTitleColor(UIColor.black, for: .normal)
         self.view.addSubview(cancelAccount)
        // added constraints
        cancelAccount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelAccount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelAccount.topAnchor.constraint(equalTo: createAccount.bottomAnchor, constant: 15),
            cancelAccount.widthAnchor.constraint(equalToConstant: 260),
            cancelAccount.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc func cancelAccountButton() {
        // Navigate - to newUserViewController
        
        dismiss(animated: true, completion: {
            UIApplication.shared.windows.first!.rootViewController = GetStartedLoginViewController()
        })
    }
}
