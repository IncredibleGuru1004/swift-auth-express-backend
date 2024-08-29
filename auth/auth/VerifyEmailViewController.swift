//
//  VerifyEmailViewController.swift
//  auth
//
//  Created by mac on 28.08.2024.
//

import Foundation
import UIKit

class VerifyEmailViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstDigitView: UIView!
    @IBOutlet weak var secondDigitView: UIView!
    @IBOutlet weak var thirdDigitView: UIView!
    @IBOutlet weak var fourthDigitView: UIView!
    @IBOutlet weak var firstDigitTextField: UITextField!
    @IBOutlet weak var secondDigitTextField: UITextField!
    @IBOutlet weak var thirdDigitTextField: UITextField!
    @IBOutlet weak var fourthDigitTextField: UITextField!
    @IBOutlet weak var resendCodeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextfield()
        setupUI()
    }
    
    func setupUI () {
        firstDigitView.layer.cornerRadius = 22
        secondDigitView.layer.cornerRadius = 22
        thirdDigitView.layer.cornerRadius = 22
        fourthDigitView.layer.cornerRadius = 22
    }
    
    func initTextfield () {
        firstDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        secondDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        thirdDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fourthDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        if text.count >= 1 {
            switch textField {
            case firstDigitTextField:
                secondDigitTextField.becomeFirstResponder()
            case secondDigitTextField:
                thirdDigitTextField.becomeFirstResponder()
            case thirdDigitTextField:
                fourthDigitTextField.becomeFirstResponder()
            case fourthDigitTextField:
                textField.resignFirstResponder()
                confirmCode()
            default:
                break
            }
        }
    }
    
    // This method is optional if you want to limit character entry to a single character in each text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 1
    }
    
    func confirmCode () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ResetPasswordViewController") as? ResetPasswordViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func onResendCodeClick () {
        
    }
    
    @IBAction func onBackClick () {
        navigationController?.popViewController(animated: true)
    }
}
