//
//  GetStartedLoginViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 3/26/21.
//
import Foundation
import UIKit

class GetStartedLoginViewController: UIViewController {
    
    let imageView = UIImageView(image: UIImage(named: "logo_image")!)
    let loginButton = UIButton(type: .system)
    let getStartedButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        companyLogo()
        login()
        getStarted()
    }
    
    // should I just re-create the image using CGRect? Mmmmmhh (less pixelated)
    func companyLogo() {
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // added constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -110.0),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func login() {
        loginButton.setTitle("Login", for: [])
        loginButton.titleLabel?.font = UIFont(name:"FontAwesome", size: 35)
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.addTarget(self, action:#selector(loginAccountButton), for:.touchUpInside)
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        // addedd contraints
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //where is the top Anchor connected to ???! Black Magic ?
            //loginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func getStarted() {
        getStartedButton.setTitle("Get Started", for: [])
        getStartedButton.titleLabel?.font = UIFont(name:"FontAwesome", size: 35)
        getStartedButton.setTitleColor(UIColor.black, for: .normal)
        getStartedButton.addTarget(self, action:#selector(openGetStarted), for:.touchUpInside)

        self.view.addSubview(getStartedButton)
        getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        // added constraints
        NSLayoutConstraint.activate([
            getStartedButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            getStartedButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40),
            getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            getStartedButton.widthAnchor.constraint(equalToConstant: 300),
            getStartedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func loginAccountButton() {
        
        dismiss(animated: true, completion: {
            UIApplication.shared.windows.first!.rootViewController = LoginScreenViewController()
        })
    }
    
    @objc func openGetStarted() {
        dismiss(animated: true, completion: {
            UIApplication.shared.windows.first!.rootViewController =  CreateAccountViewController()
        })
    }
}
