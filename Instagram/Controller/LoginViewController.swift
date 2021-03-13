//
//  LoginViewController.swift
//  Instagram
//
//  Created by Christopher Mena on 3/12/21.
//

import UIKit
import Parse
import SwiftHEXColors
class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    var buttonColor = [false, false]
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.tag = 0
        passwordField.tag = 1
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func onSignIn(_ sender: UIButton) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                
                self.performSegue(withIdentifier: "loginSegue", sender: self)
                self.usernameField.text = ""
                self.passwordField.text = ""
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            } else  {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func textFiedlChanged(_ sender: UITextField) {
        let colorLogin = UIColor(hexString: "#0095F6")
        let colorEmpty = UIColor(hexString: "B7DEFC")
        if sender.text != "" {
            buttonColor[sender.tag] = true
        }
        if buttonColor[0] && buttonColor[1] {
            logInButton.backgroundColor = colorLogin
        }
        else {
            logInButton.backgroundColor = colorEmpty
        }
    }
    @IBAction func onReveal(_ sender: UIButton) {
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
            sender.setBackgroundImage(UIImage(named: "eye"), for: .normal)
        } else {
            passwordField.isSecureTextEntry = true
            sender.setBackgroundImage(UIImage(named: "eye.slash"), for: .normal)
        }
    }
    
}
