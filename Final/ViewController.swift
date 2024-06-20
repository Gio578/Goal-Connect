//
//  ViewController.swift
//  Final
//
//  Created by Giovanni Rivera on 11/1/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var segControl: UISegmentedControl!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmPasswordTextField.isHidden = true
        
        let backButton = UIBarButtonItem()
        backButton.title = "Sign Out"
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @IBAction func segmentChange(_ sender: Any) {
        switch segControl.selectedSegmentIndex {
        case 0:
            confirmPasswordTextField.isHidden = true
            signInButton.setTitle("Sign In", for: .normal)
        case 1:
            signInButton.setTitle("Sign Up", for: .normal)
            confirmPasswordTextField.isHidden = false
        default:
            signInButton.setTitle("Sign Up", for: .normal)
        }
    }

    @IBAction func signInButton(_ sender: Any) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
                showErrorAlert(message: "Please enter your email.")
                return
            }
            
            guard let password = passwordTextField.text, !password.isEmpty else {
                showErrorAlert(message: "Please enter your password.")
                return
            }
            
            if segControl.selectedSegmentIndex == 0 {
                signInUser(email: email, password: password)
            } else {
                guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
                    showErrorAlert(message: "Please confirm your password.")
                    return
                }
                
                guard confirmPassword == password else {
                    showErrorAlert(message: "Passwords do not match.")
                    return
                }
                
                signUpUser(email: email, password: password)
            }
    }

    private func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showErrorAlert(message: error.localizedDescription)
                return
            }
            if authResult?.user != nil {
                self?.performSegue(withIdentifier: "signInSegueIdentifier", sender: self)
            }
        }
    }

    private func signUpUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.showErrorAlert(message: error.localizedDescription)
                return
            }
            if authResult?.user != nil {
                self?.performSegue(withIdentifier: "signInSegueIdentifier", sender: self)
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
}

