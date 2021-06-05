//
//  nameYourGoalViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/4/21.
//

import UIKit
import Firebase

class LocationViewController: UIViewController {
    
    let db = Firestore.firestore();
    
    let locationLabel = UILabel()
    let nameLocation = UITextField()
    let line = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centerLogo()        // center text logo (e.g. buy home)
        displayGoalTextField()  // name your goal Label
        blackLine()
        continueButton()
        view.backgroundColor = .white
    }
        
   private func centerLogo() {
        locationLabel.textColor = UIColor.white
        locationLabel.textAlignment = .center
        locationLabel.backgroundColor = UIColor.systemGray
        locationLabel.text = "Enter Location of Desired Home"
        self.view.addSubview(locationLabel)
        // added constraints
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            locationLabel.widthAnchor.constraint(equalToConstant: 275),
            locationLabel.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
        
    public func displayGoalTextField() {
        nameLocation.placeholder = "Enter Location"
        nameLocation.backgroundColor = UIColor.white
        nameLocation.textColor = UIColor.black
        self.view.addSubview(nameLocation)
        // added constraints
        nameLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLocation.centerXAnchor.constraint(equalTo: locationLabel.centerXAnchor),
            nameLocation.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50),
            nameLocation.widthAnchor.constraint(equalToConstant: 250),
            nameLocation.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func blackLine() {
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        // added constraints
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: nameLocation.centerXAnchor),
            line.topAnchor.constraint(equalTo: nameLocation.bottomAnchor, constant: 3),
            line.widthAnchor.constraint(equalToConstant: 250),
            line.heightAnchor.constraint(equalToConstant: 2)
            ])
    }
        
   func continueButton() {
        button.backgroundColor = UIColor.gray
        button.setTitle("Continue", for: [])
        button.addTarget(self, action:#selector(continueButtonPressed), for:.touchUpInside)
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: line.centerXAnchor),
            button.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 140),
            button.widthAnchor.constraint(equalToConstant: 250),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func isValidLocationInput(_ location: String) -> Bool{
       let locationRegEx = "[A-Za-z,\\s]{1,}"
        
        let locationPred = NSPredicate(format:"SELF MATCHES %@", locationRegEx)
        return locationPred.evaluate(with: location)
    }
        
    @objc func continueButtonPressed() {
        if isValidLocationInput(nameLocation.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter valid location input.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            let location : String = nameLocation.text!

            db.collection("users").document(NewUserViewController().returnEmail()).setData([ "Location": location], merge: true)

            
            let homepageVC = UIStoryboard(name: "Main", bundle: nil)

            self.dismiss(animated: true, completion: {
              UIApplication.shared.windows.first!.rootViewController = homepageVC.instantiateInitialViewController()
            })
        }
    }

}
