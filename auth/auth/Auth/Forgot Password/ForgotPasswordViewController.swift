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
    
    private func forgotPassword(with info: [String: String], completion: @escaping (Bool, String) -> Void) {
        guard let url = URL(string: "http://localhost:3001/auth/forgotPassword") else {
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
                    completion(true, "Verification Code sent successfully")
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
