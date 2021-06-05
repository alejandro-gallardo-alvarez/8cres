//
//  nameYourGoalViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/4/21.
//

import UIKit
import Firebase

class IncomeViewController: UIViewController, UITextFieldDelegate{
    
    let db = Firestore.firestore();
    
    let incomeLabel = UILabel()
    let nameIncome = UITextField()
    let line = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        nameIncome.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centerLogo()        // center text logo (e.g. buy home)
        displayGoalTextField()  // name your goal Label
        blackLine()
        continueButton()
        view.backgroundColor = .white
    }
        
   private func centerLogo() {
        incomeLabel.textColor = UIColor.white
        incomeLabel.textAlignment = .center
        incomeLabel.backgroundColor = UIColor.systemBlue
        incomeLabel.text = "What is your Income"
        self.view.addSubview(incomeLabel)
        // added constraints
        incomeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            incomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            incomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            incomeLabel.widthAnchor.constraint(equalToConstant: 275),
            incomeLabel.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    //function to make sure that only numbers are input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func isValidIncomeInput(_ income: String) -> Bool {
        let incomeRegEx = "[0-9]{1,}"
         
         let incomePred = NSPredicate(format:"SELF MATCHES %@", incomeRegEx)
         return incomePred.evaluate(with: income)
    }
    
    private func displayGoalTextField() {
        nameIncome.placeholder = "Enter Income"
        nameIncome.backgroundColor = UIColor.white
        nameIncome.textColor = UIColor.black
        self.view.addSubview(nameIncome)
        // added constraints
        nameIncome.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameIncome.centerXAnchor.constraint(equalTo: incomeLabel.centerXAnchor),
            nameIncome.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 50),
            nameIncome.widthAnchor.constraint(equalToConstant: 250),
            nameIncome.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    private func blackLine() {
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        // added constraints
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: nameIncome.centerXAnchor),
            line.topAnchor.constraint(equalTo: nameIncome.bottomAnchor, constant: 3),
            line.widthAnchor.constraint(equalToConstant: 250),
            line.heightAnchor.constraint(equalToConstant: 2)
            ])
    }
        
   private func continueButton() {
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
        
    @objc private func continueButtonPressed() {
        if isValidIncomeInput(nameIncome.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter valid income.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            let income : String = nameIncome.text!
            
            db.collection("users").document(NewUserViewController().returnEmail()).setData([ "Income": income], merge: true)
            
            let checkingIncome = (Double(income)!)*0.09
            let checkingAmount = String(format: "%.f", checkingIncome)
            self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "CheckingAccount": String(checkingAmount)], merge: true)
            
            let savingsIncome = (Double(income)!)*0.17
            let savingsAmount = String(format: "%.f", savingsIncome)
            self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "SavingsAccount": String(savingsAmount)], merge: true)
            
            dismiss(animated: true, completion: {
                UIApplication.shared.windows.first!.rootViewController = PriceViewController()
            })
        }
    }

}
