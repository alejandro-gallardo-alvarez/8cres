import UIKit
import FirebaseAuth
import Firebase

class NewUserViewController: UIViewController {
    
    let userProfileLabel = UILabel()
    let firstName = UITextField()
    let lastName = UITextField()
    let phoneNumber = UITextField()
    let nextPage = UIButton()
    let cancelAccount = UIButton()

    // add DB reference
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        userProfile()
        firstNameTextfield()
        lastNameTextfield()
        phoneNumberTextfield()
        nextButton()
    }
    
    private func userProfile() {
        userProfileLabel.textAlignment = .center
        userProfileLabel.text = "User Profile"
        self.view.addSubview(userProfileLabel)
        // added constraints
        userProfileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userProfileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            userProfileLabel.widthAnchor.constraint(equalToConstant: 150),
            userProfileLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func firstNameTextfield() {
        firstName.textColor = UIColor.black
        firstName.textAlignment = .center
        firstName.placeholder = "First Name"
        firstName.layer.backgroundColor = UIColor.lightGray.cgColor
        self.view.addSubview(firstName)
        // added constraints
        firstName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstName.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            firstName.widthAnchor.constraint(equalToConstant: 260),
            firstName.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    private func lastNameTextfield() {
        lastName.textColor = UIColor.black
        lastName.textAlignment = .center
        lastName.placeholder = "Last Name"
        lastName.layer.backgroundColor = UIColor.lightGray.cgColor
        lastName.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(lastName)
        // added constraints
        lastName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lastName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 15),
            lastName.widthAnchor.constraint(equalToConstant: 260),
            lastName.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func phoneNumberTextfield () {
        phoneNumber.textColor = UIColor.black
        phoneNumber.textAlignment = .center
        phoneNumber.placeholder = "Phone #: as ###-###-####"
        phoneNumber.layer.backgroundColor = UIColor.lightGray.cgColor
        self.view.addSubview(phoneNumber)
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumber.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 15),
            phoneNumber.widthAnchor.constraint(equalToConstant: 260),
            phoneNumber.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func nextButton() {
        nextPage.setTitle("Next", for: [])
        nextPage.titleLabel?.font = UIFont(name:"FontAwesome", size: 35)
        nextPage.addTarget(self, action:#selector(goNextButton), for:.touchUpInside)
        nextPage.layer.backgroundColor = UIColor.lightGray.cgColor
        nextPage.setTitleColor(UIColor.black, for: .normal)
         self.view.addSubview(nextPage)
        nextPage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextPage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextPage.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 50),
            nextPage.widthAnchor.constraint(equalToConstant: 260),
            nextPage.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func isValidFirstName(_ firstName: String) -> Bool {
        let firstNameRegEx = "[A-Za-z,\\s]{1,}"

        let firstNamePred = NSPredicate(format:"SELF MATCHES %@", firstNameRegEx)
        return firstNamePred.evaluate(with: firstName)
    }
    
    func isValidLastName(_ LastName: String) -> Bool {
        let LastNameRegEx = "[A-Za-z,\\s]{1,}"

        let LastNamePred = NSPredicate(format:"SELF MATCHES %@", LastNameRegEx)
        return LastNamePred.evaluate(with: LastName)
    }
    
    func isValidPhoneNumber(_ PhoneNumber: String) -> Bool {
        let PhoneNumberRegEx = "^\\d{3}-\\d{3}-\\d{4}$"

        let PhoneNumberPred = NSPredicate(format:"SELF MATCHES %@", PhoneNumberRegEx)
        return PhoneNumberPred.evaluate(with: PhoneNumber)
    }
        
    @objc func goNextButton() {
        if isValidFirstName(firstName.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter first name.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        if isValidLastName(lastName.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter last name.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        if isValidPhoneNumber(phoneNumber.text!) == false {
            let alert = UIAlertController(title: "Sign In Failed",
                                          message: "Enter phone number in the form ###-###-####.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        if isValidFirstName(firstName.text!) == true && isValidLastName(lastName.text!) == true && isValidPhoneNumber(phoneNumber.text!) == true {
            if let userFirstName = firstName.text,let userLastName = lastName.text, let phoneNum = phoneNumber.text, let email =
                Auth.auth().currentUser?.email {
                    db.collection("users").document(email).setData([
                        "firstName": userFirstName,
                        "lastName": userLastName,
                        "PhoneNumber":phoneNum,
                        "email": email,
                        "CheckingAccountTransfer": "0",
                        "SavingsAccountTransfer": "0",
                        "Savings":"0",
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                }
            
                self.dismiss(animated: true, completion: {
                    UIApplication.shared.windows.first!.rootViewController = NameYourGoalViewController()
                })
            }
        }
    }
    
    func returnEmail() ->String{
        let email:String = (Auth.auth().currentUser?.email)!
        return email
    }
    
}
