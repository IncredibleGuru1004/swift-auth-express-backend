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
    
    private func loginUser(with info: [String: String], completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://localhost:3001/auth/login") else {
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
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(false, "Network error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(true, "Login successful")
                } else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let message = json["message"] as? String {
                            completion(false, message)
                        } else {
                            completion(false, "Login failed with unknown error")
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
    
    @IBAction func onRememberClick () {
        isRemeber = !isRemeber
        if isRemeber {
            rememberMeButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            rememberMeButton.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    
    @IBAction func onLoginClick () {
        let loginInfo = ["email":emailTextField.text!, "password": passwordTextField.text!]
        self.loginUser(with: loginInfo) { success , message in
            if success {
                print("User logged in: \(message)")
                DispatchQueue.main.async {
                    self.navigateToHomePageViewController()
                }
            } else {
                print("Login faild: \(message)")
            }
        }
    }
    
    @IBAction func onRegisterClick () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onForgotPasswordClick () {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onGoogleClick () {
        
    }
    
    @IBAction func onFaceBookClick () {
        
    }
    
    @IBAction func onAppleClick () {
        
    }
}
