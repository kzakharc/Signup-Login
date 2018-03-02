//
//  SignUpViewController.swift
//  JBW-Zakharchuk
//
//  Created by Kateryna Zakharchuk on 3/1/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var letMeLogInButton: UIButton!
    var currentSelectedTextField: UITextField!
    var user = UserStruct()
    var request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.repeatPasswordField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func touchSingUp(_ sender: Any) {
        if let username = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let passwordRepeat = repeatPasswordField.text {
            if (username.isEmpty || email.isEmpty || password.isEmpty || passwordRepeat.isEmpty) {
                displayAlertMessage(message: "All fields are required!")
                return;
            }
            if (password != passwordRepeat) {
                displayAlertMessage(message: "Passwords don't match!")
                self.passwordTextField.text = ""
                self.repeatPasswordField.text = ""
                return;
            }
            user.name = username
            user.email = email
            user.password = password
            self.request.signUpRequest(user: self.user, completion: {  [weak self] (dic, error) in
                if let data = dic?.value(forKey: "data") as? NSDictionary {
                    if let t = data.value(forKey: "access_token") as? String {
                        self?.request.token = t; print("You sign up successfully. Token=\(t)")
                        DispatchQueue.main.async {
                            self?.performSegueToReturnBack()
                        }
                    } else if let error = dic?.value(forKey: "errors") as? [NSDictionary] {
                        if let err = error[0].value(forKey: "message") as? String {
                            self?.displayAlertMessage(message: err)
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func touchLogin(_ sender: UIButton) {
        performSegueToReturnBack()
    }
    
    // MARK: Alert Massage
    
    func displayAlertMessage(message: String) {
        let myAlert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let actionOk = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(actionOk)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    // MARK: keyboard settings
    
    @objc func keyboardWillShow(sender: NSNotification) {
        if currentSelectedTextField != nameTextField {
            self.view.frame.origin.y -= 75
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        if currentSelectedTextField != nameTextField && self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 75
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentSelectedTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        currentSelectedTextField = nil
    }
}

extension UIViewController {
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
