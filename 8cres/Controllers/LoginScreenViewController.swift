//
//  loginScreenViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/2/21.
//
import UIKit
import UIKit
import Firebase

class LoginScreenViewController: UIViewController {

    let loginLabel = UILabel()
    let enterEmail = UITextField()
    let enterPass = UITextField()
    let loginButton = UIButton()
    let cancelAccount = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        loginLabelPlacement()
        emailPlacement()
        passPlacement()
        loginButtonPlacement()
        cancelAccntFun()
    }
    
    func loginLabelPlacement() {
        loginLabel.textAlignment = .center
        loginLabel.text = "Login"
        self.view.addSubview(loginLabel)
        // added constraints
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            loginLabel.widthAnchor.constraint(equalToConstant: 100),
            loginLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func emailPlacement() {
        enterEmail.textColor = UIColor.black
        enterEmail.textAlignment = .center
        enterEmail.placeholder = "Email"
        enterEmail.layer.backgroundColor = UIColor.lightGray.cgColor
        enterEmail.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(enterEmail)
        // added constraints
        enterEmail.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterEmail.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            enterEmail.widthAnchor.constraint(equalToConstant: 260),
            enterEmail.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
        
    func passPlacement() {
        enterPass.textColor = UIColor.black
        enterPass.textAlignment = .center
        enterPass.placeholder = "Enter password"
        enterPass.layer.backgroundColor = UIColor.lightGray.cgColor
        enterPass.isSecureTextEntry = true
        self.view.addSubview(enterPass)
        // added constraints
        enterPass.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterPass.centerXAnchor.constraint(equalTo: enterEmail.centerXAnchor),
            enterPass.topAnchor.constraint(equalTo: enterEmail.bottomAnchor, constant: 20),
            enterPass.widthAnchor.constraint(equalToConstant: 260),
            enterPass.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func loginButtonPlacement() {
        loginButton.setTitle("Login", for: [])
        loginButton.titleLabel?.font = UIFont(name:"FontAwesome", size: 35)
        loginButton.layer.backgroundColor = UIColor.lightGray.cgColor
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.addTarget(self, action:#selector(loginAccountButton), for:.touchUpInside)
         self.view.addSubview(loginButton)
        // added constraints
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: enterPass.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: enterPass.bottomAnchor, constant: 100),
            loginButton.widthAnchor.constraint(equalToConstant: 260),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @objc func loginAccountButton() {
        // check correct format of email
        if isValidEmail(enterEmail.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "The email adress is badly formatted,",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
        let email = enterEmail.text!
            
        guard
              let password = enterPass.text,
              password.count > 0
          else {
            return
        }

        // user signs in here
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
          if let error = error, user == nil {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
          } else{
            let homepageVC = UIStoryboard(name: "Main", bundle: nil)
                    
            self.dismiss(animated: true, completion: {
              UIApplication.shared.windows.first!.rootViewController = homepageVC.instantiateInitialViewController()
            })
          }
        }
    }
    
    private func cancelAccntFun() {
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
            cancelAccount.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            cancelAccount.widthAnchor.constraint(equalToConstant: 260),
            cancelAccount.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    @objc private func cancelAccountButton() {
        // Navigate - to newUserViewController
        
        dismiss(animated: true, completion: {
            UIApplication.shared.windows.first!.rootViewController = GetStartedLoginViewController()
        })
    }
 
}
