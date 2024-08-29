//
//  ForgotPasswordViewController.swift
//  auth
//
//  Created by mac on 28.08.2024.
//

import Foundation
import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailLeftImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupUI()
    }
    
    func setupUI () {
        emailView.layer.cornerRadius = 20
        emailLeftImageView.image = UIImage(systemName: "envelope")
        emailTextField.placeholder = "E-Mail"
    }
    
    @IBAction func onSendClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "VerifyEmailViewController") as? VerifyEmailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onBackClick() {
        navigationController?.popViewController(animated: true)
    }
}
