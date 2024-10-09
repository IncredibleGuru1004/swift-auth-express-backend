import Foundation
import UIKit
import PhoneNumberKit

class SendPhoneCodeViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet weak var phoneNumberView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneNumberTextField.withPrefix = true
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withExamplePlaceholder = true
        phoneNumberTextField.countryCodePlaceholderColor = .blue
        
        phoneNumberView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func sendButtonClicked() {
        let phoneNumberKit = PhoneNumberUtility()
        
        do {
            let phoneNumber = try phoneNumberKit.parse(phoneNumberTextField.text!)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyboard.instantiateViewController(identifier: "VerifyOTPcodeViewController") as? VerifyOTPcodeViewController {
                vc.phoneNumber = phoneNumberKit.format(phoneNumber, toType: .e164)
                navigationController?.pushViewController(vc, animated: true)
            }
        } catch {
            let alert = UIAlertController(title: "Invalid Phone Number", message: "Please enter a valid phone number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
}
