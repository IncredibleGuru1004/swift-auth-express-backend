import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register a new user; change the email to one that might already exist to test the error handling
        let registrationInfo = ["username": "user1", "email": "user1@example.com", "password": "password123"]
        registerUser(with: registrationInfo) { success, message in
            if success {
                print("User registered: \(message)")
                
                // Attempt to login
                let loginInfo = ["username": "user1", "password": "password123"]
                self.loginUser(with: loginInfo) { success, message in
                    if success {
                        print("User logged in: \(message)")
                    } else {
                        print("Login failed: \(message)")
                    }
                }
            } else {
                print("Registration failed: \(message)")
            }
        }
    }
    
    // MARK: - Networking
    
    func registerUser(with info: [String: String], completion: @escaping (Bool, String) -> Void) {
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
    
    func loginUser(with info: [String: String], completion: @escaping (Bool, String) -> Void) {
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
}
