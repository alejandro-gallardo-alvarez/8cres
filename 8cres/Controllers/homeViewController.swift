//
//  nameYourGoalViewController.swift
//  8cres
//
//  Created by Ashton Reed Humphrey on 4/4/21.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    let db = Firestore.firestore()

    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    @IBOutlet weak var plaidButton: UIButton!
    
    @IBOutlet weak var savings: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var monthsToGoal: UILabel!
    @IBOutlet weak var savedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readArray()
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
        
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { (action: UIAlertAction!) in }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func plaidButton(_ sender: Any) {
        presentPlaidLink()
    }
    
    func goalReachCheck(_ months: Double) -> Bool {
        if months <= 0 {
            return true
        }
        
        return false
    }
    
    func readArray(){
        // get the user data to display
        // different for each user
       self.db.collection("users").getDocuments { (snapshot, err) in
           if let err = err {
               print("Error getting documents: \(err)")
           } else {
               for document in snapshot!.documents {
                    if document.documentID == NewUserViewController().returnEmail(){
                        let savedMoney = document.get("Savings") as! String
                        self.savings.text = savedMoney
                        
                        
                        let daysSaved = Double(savedMoney)!
                        self.savedLabel.text = "You saved $" +  String(format: "%.f", daysSaved) + " in the last 30 days"
                        
                        self.location.text = (document.get("Location") as! String)

                        let inputPrice = document.get("Price") as! String
                        self.price.text = String(format: "%.1f", Double(inputPrice)!)
                        let numPrice = Double(inputPrice)
                        let downPayment = (numPrice!)*0.20
                        self.goal.text = String(format: "%.1f",downPayment)
                        
                        let checkingTransfer = document.get("CheckingAccountTransfer") as! String
                        let savingsTranfer = document.get("SavingsAccountTransfer") as! String
                        let totalTransfer = Double(checkingTransfer)! + Double(savingsTranfer)! + 1
                        let monthsLeft = (downPayment - Double(savedMoney)!)/totalTransfer
                        
                        if self.goalReachCheck(monthsLeft) == true {
                            self.monthsToGoal.text = "Congratulations! goal reached"
                        }
                        else {
                            let monthsString: String = " months from reaching goal"
                            let monthsSaved: String = String(format: "%.f", monthsLeft)
                            self.monthsToGoal.text = monthsSaved + monthsString
                        }
                    }
               }
           }
       }
    }
    
    @IBAction func profile(_ sender: Any) {
        let homepageVC = UIStoryboard(name: "Profile", bundle: nil)
                
        self.dismiss(animated: true, completion: {
          UIApplication.shared.windows.first!.rootViewController = homepageVC.instantiateInitialViewController()
        })
    }
    
    @IBAction func balanceButton(_ sender: Any) {
        let homepageVC = UIStoryboard(name: "Bank", bundle: nil)
                
        self.dismiss(animated: true, completion: {
          UIApplication.shared.windows.first!.rootViewController = homepageVC.instantiateInitialViewController()
        })
    }
    
}
