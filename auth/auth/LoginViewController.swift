//
//  LoginViewController.swift
//  auth
//
//  Created by mac on 23.08.2024.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLeftImageView: UIImageView!
    @IBOutlet weak var emailRightImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordLeftImageView: UIImageView!
    @IBOutlet weak var passwordRightImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    var isPasswordHidden: Bool = true
    var isRemeber: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    func setupUI () {
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
    
    @IBAction func onRememberClick () {
        isRemeber = !isRemeber
        if isRemeber {
            rememberMeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func onLoginClick () {
        
    }
    
    @IBAction func onRegisterClick () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onForgotPasswordClick () {
        
    }
    
    @IBAction func onGoogleClick () {
        
    }
    
    @IBAction func onFaceBookClick () {
        
    }
    
    @IBAction func onAppleClick () {
        
    }
}
