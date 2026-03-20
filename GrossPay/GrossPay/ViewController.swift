//
//  ViewController.swift
//  GrossPay
//
//  Created by Jorge Munoz on 1/25/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //Outlets
    @IBOutlet weak var roundCorners: UIView!
    @IBOutlet weak var netCorners: UIStackView!
    @IBOutlet weak var outputCorners: UIStackView!
    
    @IBOutlet weak var netPay: UITextField!
    @IBOutlet weak var outputBills: UILabel!
    @IBOutlet weak var outputPersonal: UILabel!
    @IBOutlet weak var outputSavDeb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the view and constraints
        viewAdjust()
        
        //keyboard setup
        netPay.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //keyboard shows or hides
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Function to adjust views
    func viewAdjust() {
        // Round corners
        roundCorners.layer.cornerRadius = 10
        netCorners.layer.cornerRadius = 10
        outputCorners.layer.cornerRadius = 10
    }
    
    // Function that collects net pay data and calculates 50%, 30%, 20%
    @IBAction func calculateTap(_ sender: Any) {
        // Converting string input to double
        if let net = netPay.text, let netPayout = Double(net) {
            // Calculations
            let bills = netPayout * 0.5
            let personal = netPayout * 0.3
            let savDev = netPayout * 0.2
            
            // Output to labels
            outputBills.text = "$\(String(format: "%.2f", bills))"
            outputPersonal.text = "$\(String(format: "%.2f", personal))"
            outputSavDeb.text = "$\(String(format: "%.2f", savDev))"
        }
    }
    
    // MARK: insert keyboard methods
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //add these methods to combine all the necessary bode to appear
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    // Function to move view back when keyboard disappears
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    // Additional methods for your class...
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
