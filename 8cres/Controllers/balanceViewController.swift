//
//  File.swift
//  8cres
//
//  Created by Alejandro Gallardo alvarez on 5/30/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class BalanceViewController: UIViewController, UITextFieldDelegate {

    let db = Firestore.firestore()
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var checkingTransferButton: UIButton!
    @IBOutlet weak var savingsTransferButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var transferFromChecking: UITextField!
    @IBOutlet weak var transferFromSavings: UITextField!
    @IBOutlet weak var checkingAmount: UILabel!
    @IBOutlet weak var savingsAmount: UILabel!
   
    override func viewDidLoad() {
        transferFromChecking.delegate = self
        transferFromSavings.delegate = self
        
        super.viewDidLoad()
        readArray()
    }
    
    @IBAction func profileButton(_ sender: Any) {
        let homepageVC = UIStoryboard(name: "Profile", bundle: nil)

        self.dismiss(animated: true, completion: {
          UIApplication.shared.windows.first!.rootViewController = homepageVC.instantiateInitialViewController()
        })
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let homepageVC = UIStoryboard(name: "Main", bundle: nil)

        self.dismiss(animated: true, completion: {
          UIApplication.shared.windows.first!.rootViewController = homepageVC.instantiateInitialViewController()
        })
    }
    
    @IBAction func logout(_ sender: Any) {
        let alert = UIAlertController(title: "Logout",
                                      message: "You will be logout",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { (action: UIAlertAction!) in
            // make sure to log user out of firebase too
            do { try Auth.auth().signOut() }
                catch { print("already logged out") }

            self.dismiss(animated: true, completion: {
                UIApplication.shared.windows.first!.rootViewController = GetStartedLoginViewController()
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //function to make sure that only numbers are input
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func isOverdraftValidation(_ balance :Double) -> Bool {
        if balance < 0 {
            return true
        }
        return false
        
    }
    
    func validateTransferIsNotEmpty(_ transfer: String) -> Bool {
        if transfer.isEmpty {
            return true
        }
      return false
    }
    
    @IBAction func checkingTransferButton(_ sender: Any) {
        if validateTransferIsNotEmpty(transferFromChecking.text!) == true {
            let alert = UIAlertController(title: "Error",
                                          message: "Enter Amount to trasnfer from Savings Account.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.db.collection("users").getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                         if document.documentID == NewUserViewController().returnEmail(){
                             let totalSaved = document.get("Savings") as! String
                             let numIncome = Double(totalSaved)! + Double(self.transferFromChecking.text!)!
                             let savedMoney = numIncome
                            let moneyUpload: String = String(format: "%.f", savedMoney)
                         
                            let oldCheckingAccount = document.get("CheckingAccount") as! String
                            let newCheckingAccount = Double(oldCheckingAccount)! - Double(self.transferFromChecking.text!)!
                            
                            if  self.isOverdraftValidation(newCheckingAccount) == true {
                                let alert = UIAlertController(title: "Error",
                                                              message: "You do not have enough available balance in Checking Account for this transfer.",
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(alert, animated: true, completion: nil)
                            }
                            else {
                                let upLoadCheckingAccount = String(newCheckingAccount)
                                
                                self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "Savings": moneyUpload], merge: true)
                                self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "CheckingAccount": upLoadCheckingAccount], merge: true)
                                self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "CheckingAccountTransfer": self.transferFromChecking.text!], merge: true)
                                
                                let alert = UIAlertController(title: "Success",
                                                              message: "Money has been transferred to 8cres savings.",
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                
                                self.transferFromChecking.text?.removeAll()
                            }
                         }
                    }
                }
            }
        }
    }
    
    @IBAction func savingsTransferButton(_ sender: Any) {
        if validateTransferIsNotEmpty(transferFromSavings.text!) == true {
            let alert = UIAlertController(title: "Error",
                                          message: "Enter Amount to trasnfer from Savings Account.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else{
            self.db.collection("users").getDocuments { (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in snapshot!.documents {
                         if document.documentID == NewUserViewController().returnEmail(){
                            let totalSaved = document.get("Savings") as! String
                            let numIncome = Double(totalSaved)! + Double(self.transferFromSavings.text!)!
                            let savedMoney = numIncome
                            let moneyUpload: String = String(format: "%.f", savedMoney)
                            
                            let oldSavingsAccount = document.get("SavingsAccount") as! String
                            let newSavingsAccount = Double(oldSavingsAccount)! - Double(self.transferFromSavings.text!)!
                            
                            if self.isOverdraftValidation(newSavingsAccount) == true{
                                let alert = UIAlertController(title: "Error",
                                                              message: "You do not have enough available balance in Savings Account for this transfer.",
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(alert, animated: true, completion: nil)
                            }
                            else {
                                let uploadSavingsAccount = String(newSavingsAccount)
                                
                                self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "Savings": moneyUpload], merge: true)
                                self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "SavingsAccount": uploadSavingsAccount], merge: true)
                                self.db.collection("users").document(NewUserViewController().returnEmail()).setData([ "SavingsAccountTransfer": self.transferFromSavings.text!], merge: true)
                                
                                let alert = UIAlertController(title: "Success",
                                                              message: "Money has been transferred to 8cres savings.",
                                                              preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(alert, animated: true, completion: nil)
                                
                                self.transferFromSavings.text?.removeAll()
                            }
                         }
                    }
                }
            }
            
        }
    }
    
    func readArray(){
      self.db.collection("users").getDocuments { (snapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
            for document in snapshot!.documents {
              if document.documentID == NewUserViewController().returnEmail(){
                self.checkingAmount.text = (document.get("CheckingAccount") as! String)
                self.savingsAmount.text = (document.get("SavingsAccount") as! String)
            }
          }
        }
      }
    }
}

