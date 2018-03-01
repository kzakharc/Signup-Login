//
//  LogInViewController.swift
//  JBW-Zakharchuk
//
//  Created by Kateryna Zakharchuk on 3/1/18.
//  Copyright © 2018 Kateryna Zakharchuk. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logInEmailTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var logInButton: UIButton!
    var user = UserStruct()
    var request = Request()
    var story = Text()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.logInEmailTextField.delegate = self
        self.logInPasswordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func touchLogIn(_ sender: UIButton) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let email = logInEmailTextField.text, let password = logInPasswordTextField.text {
            if (email.isEmpty || password.isEmpty) {
                displayAlertMassage(message: "All fields are required!")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                return;
            }
            user.email = email
            user.password = password
            self.request.logInRequest(user: self.user, completion: { [weak self] (dic, error) in
                if let data = dic?.value(forKey: "data") as? NSDictionary {
                    if let t = data.value(forKey: "access_token") as? String {
                        self?.request.token = t; print("You log in successfully. Token:\(t)")
                        self?.request.getInfo(completion: { (dic, err) in
                            if let text = dic?.value(forKey: "data") as? String {
                                self?.story.text = text
                                DispatchQueue.main.async {
                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                    self?.performSegue(withIdentifier: "displayResults", sender: self)
                                    self?.clearFields()
                                }
                            }
                        })
                    } else if let error = dic?.value(forKey: "errors") as? [NSDictionary] {
                        if let err = error[0].value(forKey: "message") as? String {
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            self?.displayAlertMassage(message: err)
                            self?.clearFields()
                        }
                    }
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "displayResults") {
            let dectinationView: ResultsTableViewController = segue.destination as! ResultsTableViewController
            dectinationView.story = self.story
        }
    }
    
    // MARK: Alert Massage
    
    func displayAlertMassage(message: String) {
        let myAlert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let actionOk = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(actionOk)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    // MARK: keyboard settings
    
    @objc func keyboardWillShow(sender: NSNotification) { self.view.frame.origin.y = -50 }
    @objc func keyboardWillHide(sender: NSNotification) { self.view.frame.origin.y = 0 }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) { self.view.endEditing(true) }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK just for help
    
    func clearFields() {
        self.logInEmailTextField.text = ""
        self.logInPasswordTextField.text = ""
    }
}

