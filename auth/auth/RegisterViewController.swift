//
//  RegisterViewController.swift
//  auth
//
//  Created by mac on 24.08.2024.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var userNameLeftImageView:UIImageView!
    @IBOutlet weak var userNameTextField:UITextField!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLeftImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordLeftImageView: UIImageView!
    @IBOutlet weak var passwordRightImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var agreeButton: UIButton!
    
    var isPasswordHidden: Bool = false
    var isAgree: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    func setupUI () {
        userNameView.layer.cornerRadius = 20
        userNameLeftImageView.image = UIImage(systemName: "person")
        userNameTextField.placeholder = "User Name"
        
        emailView.layer.cornerRadius = 20
        emailLeftImageView.image = UIImage(systemName: "envelope")
        emailTextField.placeholder = "E-Mail"
        
        passwordView.layer.cornerRadius = 20
        passwordLeftImageView.image = UIImage(systemName: "lock")
        passwordRightImageView.image = UIImage(systemName: "eye")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
    }
    
    @IBAction func onTogglePasswordClick () {
        isPasswordHidden = !isPasswordHidden
        if isPasswordHidden {
            passwordRightImageView.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = true
        } else {
            passwordRightImageView.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    @IBAction func onAgreeClick () {
        isAgree = !isAgree
        if isAgree {
            agreeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            agreeButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func onPrivacyAndPolicyClick () {
        
    }
    
    @IBAction func onRegisterClick () {
        
    }
    
    @IBAction func onLoginClick () {
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if viewController is LoginViewController {
                    navigationController?.popToViewController(viewController, animated: true)
                    break
                }
            }
        }
    }
    
    @IBAction func onGoogleClick () {
        
    }
    
    @IBAction func onFaceBookClick () {
        
    }
    
    @IBAction func onAppleClick () {
        
    }
}
