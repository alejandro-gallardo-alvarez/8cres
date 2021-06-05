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

class ProfileViewController: UIViewController {

    let db = Firestore.firestore()
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var balanceButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var deleteAccountButton: UIButton!
    
    @IBOutlet weak var inputName: UILabel!
    @IBOutlet weak var inputEmail: UILabel!
    @IBOutlet weak var inputNumber: UILabel!
    @IBOutlet weak var inputIncome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readArray()
    }
    
    @IBAction func homeButton(_ sender: Any) {
        let homepageVC = UIStoryboard(name: "Main", bundle: nil)
                
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
    
    
    @IBAction func logOut(_ sender: Any) {
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
    
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Account",
                                      message: "Account will be deleted",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { (action: UIAlertAction!) in
            let user = Auth.auth().currentUser
            user?.delete { error in
                if let error = error {
                    let alert = UIAlertController(title: "Delete Account Failed",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.dismiss(animated: true, completion: {
                        UIApplication.shared.windows.first!.rootViewController = GetStartedLoginViewController()
                    })
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          }))
        
        self.present(alert, animated: true, completion: nil)
        // delete current user data from app and also from firebase
    }
    
    func readArray(){
      self.db.collection("users").getDocuments { (snapshot, err) in
        if let err = err {
          print("Error getting documents: \(err)")
        } else {
            for document in snapshot!.documents {
              if document.documentID == NewUserViewController().returnEmail(){
                self.inputIncome.text = (document.get("Income") as! String)
                self.inputNumber.text = (document.get("PhoneNumber") as! String)
                self.inputEmail.text = (document.get("email") as! String)
                let firstName = document.get("firstName") as! String
                let lastName = document.get("lastName") as! String
                self.inputName.text = firstName + " " + lastName
            }
          }
        }
      }
    }
}
