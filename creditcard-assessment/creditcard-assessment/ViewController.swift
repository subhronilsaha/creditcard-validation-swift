//
//  ViewController.swift
//  creditcard-assessment
//
//  Created by Subhronil Saha on 12/11/20.
//

import UIKit
import CCValidator

class ViewController: UIViewController {
    
    @IBOutlet weak var securityCodeField : UITextField!
    @IBOutlet weak var expiryField : UITextField!
    @IBOutlet weak var firstNameField : UITextField!
    @IBOutlet weak var lastNameField : UITextField!
    @IBOutlet var cardNumberField : UITextField!
    
    @IBOutlet weak var cardValidity : UILabel!
    @IBOutlet weak var expiryValidity : UILabel!
    @IBOutlet weak var securityValidity : UILabel!
    @IBOutlet weak var fNameValidity : UILabel!
    @IBOutlet weak var lNameValidity : UILabel!


    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cardNumberField.addTarget(self, action: #selector(cardNumberFieldDidChange), for: .editingChanged)
        expiryField.addTarget(self, action: #selector(expiryFieldDidChange), for: .editingChanged)
        securityCodeField.addTarget(self, action: #selector(securityCodeFieldDidChange), for: .editingChanged)
        firstNameField.addTarget(self, action: #selector(firstNameFieldDidChange), for: .editingChanged)
        lastNameField.addTarget(self, action: #selector(lastNameFieldDidChange), for: .editingChanged)
    }
    
    //MARK:- Submit Button
    @IBAction func submitButtonTapped(_ sender: Any) {
        // if all error labels are empty strings, payment is valid
        let paymentValid = (cardValidity.text == " " && expiryValidity.text == " " && securityValidity.text == " " && fNameValidity.text == " " && lNameValidity.text == " ") ? true : false
        
        // Present alert
        if(paymentValid) {
            let alert = UIAlertController(title: "Payment Successful", message: "Your payment was successful", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter valid details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    //MARK:- Card Number Validation
    @objc func cardNumberFieldDidChange() {
        if let cardNo = cardNumberField.text {
            let cardValid = CCValidator.validate(creditCardNumber: cardNo)
            let recognizedType = CCValidator.typeCheckingPrefixOnly(creditCardNumber: cardNo)

            print(cardValid)
            
            if(cardNo.count > 13) {
                if(!cardValid) {
                    cardValidity.text = "Invalid Card"
                    cardValidity.textColor = UIColor.systemPink
                } else {
                    cardValidity.text = " "
                    cardValidity.textColor = UIColor.systemGreen
                }
            } else {
                cardValidity.text = " "
            }
            
            print("Card type: ")
            if(recognizedType == .Visa) {
                print("Visa")
            } else if(recognizedType == .Discover) {
                print("Discover")
            } else if(recognizedType == .AmericanExpress) {
                print("American Express")
            } else if(recognizedType == .MasterCard) {
                print("MasterCard")
            }
        }
    }
    
    //MARK:- Expiry Date Validation
    @objc func expiryFieldDidChange() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/YY"
        
        if let expiry = expiryField.text {
            
            // Remodify text to match MM/YY format
            if(expiry.count == 3 && expiry.last != "/") {
                let mm = expiry.prefix(2)
                let yy = expiry.dropFirst(2)
                expiryField.text = mm + "/" + yy
            }
            
            // Check is date is valid
            if let _ = dateFormatter.date(from: expiry) {
                expiryValidity.text = " "
            } else {
                // Invalid date
                expiryValidity.text = "Invalid expiry date"
                expiryValidity.textColor = .systemPink
            }
            
            // Expiry date size cannot exceed 5 characters "MM/YY"
            if(expiry.count > 5) {
                expiryValidity.text = "Invalid expiry date"
                expiryValidity.textColor = .systemPink
            }
        }
    }
    
    //MARK:- Security Code Validation
    @objc func securityCodeFieldDidChange() {
        if let cvv = securityCodeField.text {
            // Check is CVV length < 4 and if it is a number or not
            if let lastChar = cvv.last {
                if(cvv.count > 4 || !lastChar.isNumber) {
                    securityValidity.text = "Invalid CVV"
                } else {
                    securityValidity.text = " "
                }
            }
        }
    }
    
    //MARK:- First Name Validation
    @objc func firstNameFieldDidChange() {
        if let firstName = firstNameField.text {
            if let lastChar = firstName.last {
                if(!lastChar.isLetter) {
                    fNameValidity.text = "Invalid First Name"
                    fNameValidity.textColor = .systemPink
                } else {
                    fNameValidity.text = " "
                    
                }
            }
            // Capitalize 1st letter
            firstNameField.text = firstName.capitalizingFirstLetter()
        }
    }
    
    //MARK:- Last Name Validation
    @objc func lastNameFieldDidChange() {
        if let lastName = lastNameField.text {
            if let lastChar = lastName.last {
                if(!lastChar.isLetter) {
                    lNameValidity.text = "Invalid Last Name"
                    lNameValidity.textColor = .systemPink
                } else {
                    lNameValidity.text = " "
                    
                }
            }
            
            // Capitalize 1st letter
            lastNameField.text = lastName.capitalizingFirstLetter()
        }
    }

}



