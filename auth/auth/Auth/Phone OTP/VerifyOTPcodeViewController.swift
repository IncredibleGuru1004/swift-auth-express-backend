//
//  VerifyOTPcodeViewController.swift
//  auth
//
//  Created by mac on 05.10.2024.
//

import Foundation
import UIKit

class VerifyOTPcodeViewController : UIViewController {
    
    @IBOutlet weak var sentTextView: UITextView!
    
    @IBOutlet weak var firstDigitView: UIView!
    @IBOutlet weak var secondDigitView: UIView!
    @IBOutlet weak var thirdDigitView: UIView!
    @IBOutlet weak var fourthDigitView: UIView!
    @IBOutlet weak var fifthDigitView: UIView!
    @IBOutlet weak var sixthDigitView: UIView!
    
    @IBOutlet weak var firstDigitTextField: UITextField!
    @IBOutlet weak var secondDigitTextField: UITextField!
    @IBOutlet weak var thirdDigitTextField: UITextField!
    @IBOutlet weak var fourthDigitTextField: UITextField!
    @IBOutlet weak var fifthDigitTextField: UITextField!
    @IBOutlet weak var sixthDigitTextField: UITextField!
    
    var phoneNumber: String = ""
    var otpCode: String = ""
    
    @IBAction func backButtonClicked () {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onResendCodeClick () {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentTextView.text = "We have sent an OTP code to your phone No \(phoneNumber)."
        
        initTextfield()
        setupUI()
        
        sendPhoneNumber(with: phoneNumber) { status, data in
            print("\(status) otpCode: \(data)")
            if status == true {
                self.otpCode = data
            }
        }
    }
    
    func setupUI () {
        firstDigitView.layer.cornerRadius = 22
        secondDigitView.layer.cornerRadius = 22
        thirdDigitView.layer.cornerRadius = 22
        fourthDigitView.layer.cornerRadius = 22
        fifthDigitView.layer.cornerRadius = 22
        sixthDigitView.layer.cornerRadius = 22
    }
    
    func initTextfield () {
        firstDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        secondDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        thirdDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fourthDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fifthDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        sixthDigitTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
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
                fifthDigitTextField.becomeFirstResponder()
            case fifthDigitTextField:
                sixthDigitTextField.becomeFirstResponder()
            case sixthDigitTextField:
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
        
        let enteredCode = "\(firstDigitTextField.text ?? "")\(secondDigitTextField.text ?? "")\(thirdDigitTextField.text ?? "")\(fourthDigitTextField.text ?? "")\(fifthDigitTextField.text ?? "")\(sixthDigitTextField.text ?? "")"
        
        if enteredCode == otpCode {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(identifier: "ResetPasswordViewController") as? ResetPasswordViewController {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Invalid OTP code", message: "Please enter a valid OTP code.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func sendPhoneNumber(with phoneNumber: String, completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://localhost:3001/auth/phoneOTP") else {
            completion(false, "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["phoneNumber":phoneNumber]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(false, "Error serializing JSON")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, "Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let code = json["code"] as? String {
                            completion(true, code)
                        }
                    } catch {
                        completion(false, "Error parsing response JSON")
                    }
                } else {
                    completion(false, "")
                }
            } else {
                completion(false, "Unknown network error")
            }
            
        }
        task.resume()
    }

}
