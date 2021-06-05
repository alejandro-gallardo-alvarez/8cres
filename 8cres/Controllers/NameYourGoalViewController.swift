//
//  nameYourGoalViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/4/21.
//

import UIKit
import Firebase
import Foundation

class NameYourGoalViewController: UIViewController {
    let buyHome = UILabel()
    let nameGoal = UITextField()
    let line = UILabel()
    let button = UIButton()
    let db = Firestore.firestore();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centerLogo()        // center text logo (e.g. buy home)
        displayGoalTextField()  // name your goal Label
        blackLine()
        continueButton()
        view.backgroundColor = .white
        print(db);
    }
        
   func centerLogo() {
        buyHome.textColor = UIColor.white
        buyHome.textAlignment = .center
        buyHome.backgroundColor = UIColor.systemPink
        buyHome.text = "Buy a Home"
        self.view.addSubview(buyHome)
        // added constraints
        buyHome.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyHome.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyHome.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            buyHome.widthAnchor.constraint(equalToConstant: 275),
            buyHome.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
        
    func displayGoalTextField() {
        nameGoal.placeholder = "Name property goal"
        nameGoal.backgroundColor = UIColor.white
        nameGoal.textColor = UIColor.black
        self.view.addSubview(nameGoal)
        // added constraints
        nameGoal.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameGoal.centerXAnchor.constraint(equalTo: buyHome.centerXAnchor),
            nameGoal.topAnchor.constraint(equalTo: buyHome.bottomAnchor, constant: 50),
            nameGoal.widthAnchor.constraint(equalToConstant: 250),
            nameGoal.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func blackLine() {
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        // added constraints
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: nameGoal.centerXAnchor),
            line.topAnchor.constraint(equalTo: nameGoal.bottomAnchor, constant: 3),
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
    
    func isValidHomeGoal(_ goal: String) -> Bool{
       let goalRegEx = "[A-Za-z,\\s]{1,}"
        
        let goalPred = NSPredicate(format:"SELF MATCHES %@", goalRegEx)
        return goalPred.evaluate(with: goal)
    }
        
    @objc func continueButtonPressed() {
        if isValidHomeGoal(nameGoal.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter valid goal input.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            let goal : String = nameGoal.text!
           
            db.collection("users").document(NewUserViewController().returnEmail()).setData([ "Goal": goal], merge: true)
            
            dismiss(animated: true, completion: {
                UIApplication.shared.windows.first!.rootViewController = IncomeViewController()
            })
        }
    }

}
