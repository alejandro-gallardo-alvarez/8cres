//
//  nameYourGoalViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/4/21.
//

import UIKit
import Firebase

class PriceViewController: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore();
    
    let priceLabel = UILabel()
    let namePrice = UITextField()
    let line = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        namePrice.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centerLogo()        // center text logo (e.g. buy home)
        displayGoalTextField()  // name your goal Label
        blackLine()
        continueButton()
        view.backgroundColor = .white
    }
        
   private func centerLogo() {
        priceLabel.textColor = UIColor.white
        priceLabel.textAlignment = .center
        priceLabel.backgroundColor = UIColor.systemRed
        priceLabel.text = "Enter Price of Home"
        self.view.addSubview(priceLabel)
        // added constraints
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            priceLabel.widthAnchor.constraint(equalToConstant: 275),
            priceLabel.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    //function to make sure that only numbers are input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func isValidPriceInput(_ price: String) -> Bool {
        let priceRegEx = "[0-9]{1,}"
         
         let pricePred = NSPredicate(format:"SELF MATCHES %@", priceRegEx)
         return pricePred.evaluate(with: price)
    }
    
    func displayGoalTextField() {
        namePrice.placeholder = "Enter Price"
        namePrice.backgroundColor = UIColor.white
        namePrice.textColor = UIColor.black
        self.view.addSubview(namePrice)
        // added constraints
        namePrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            namePrice.centerXAnchor.constraint(equalTo: priceLabel.centerXAnchor),
            namePrice.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50),
            namePrice.widthAnchor.constraint(equalToConstant: 250),
            namePrice.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    func blackLine() {
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        // added constraints
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.centerXAnchor.constraint(equalTo: namePrice.centerXAnchor),
            line.topAnchor.constraint(equalTo: namePrice.bottomAnchor, constant: 3),
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
        
    @objc func continueButtonPressed() {
        if isValidPriceInput(namePrice.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter valid price.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            let price : String = namePrice.text!
            db.collection("users").document(NewUserViewController().returnEmail()).setData([ "Price": price], merge: true)
            dismiss(animated: true, completion: {
                UIApplication.shared.windows.first!.rootViewController = LocationViewController()
            })
        }
    }
}
