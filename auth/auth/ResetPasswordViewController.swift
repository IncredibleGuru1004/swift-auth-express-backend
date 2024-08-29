//
//  ResetPasswordViewController.swift
//  auth
//
//  Created by mac on 28.08.2024.
//

import Foundation
import UIKit

class ResetPasswordViewController : UIViewController{
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordLeftImageView: UIImageView!
    @IBOutlet weak var passwordRightImageView: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var isPasswordHidden: Bool = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI () {
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
    
    @IBAction func onSaveClick() {
        
    }
}
