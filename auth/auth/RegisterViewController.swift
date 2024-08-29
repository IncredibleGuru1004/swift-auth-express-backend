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
        userNameTextField.text = ""
        
        emailView.layer.cornerRadius = 20
        emailLeftImageView.image = UIImage(systemName: "envelope")
        emailTextField.placeholder = "E-Mail"
        emailTextField.text = ""
        
        passwordView.layer.cornerRadius = 20
        passwordLeftImageView.image = UIImage(systemName: "lock")
        passwordRightImageView.image = UIImage(systemName: "eye")
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.text = ""
    }
    
    private func navigateToHomePageViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            
            // Present the TabBarController
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: false, completion: nil)
        }
    }
    
    private func registerUser(with info: [String: String], completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://localhost:3001/auth/register") else {
            completion(false, "Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: info, options: [])
        } catch {
            completion(false, "Error serializing JSON")
            return
        }
        
        print(info)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, "Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 201 {
                    completion(true, "Registration successful")
                } else {
                    // Parse the JSON to get the message
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let message = json["message"] as? String {
                            completion(false, message)
                        } else {
                            completion(false, "Registration failed with unknown error")
                        }
                    } catch {
                        completion(false, "Error parsing response JSON")
                    }
                }
            } else {
                completion(false, "Unknown network error")
            }
        }
        task.resume()
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
        let registrationInfo = ["username": userNameTextField.text!, "email": emailTextField.text!, "password": passwordTextField.text!]
        print(registrationInfo)
        registerUser(with: registrationInfo) { success, message in
            if success {
                print("User registered: \(message)")
                DispatchQueue.main.async {
                    self.navigateToHomePageViewController()
                }
            } else {
                print("Registration failed: \(message)")
            }
        }
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
