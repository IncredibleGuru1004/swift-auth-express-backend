//
//  HomePageViewController.swift
//  auth
//
//  Created by mac on 29.08.2024.
//

import Foundation
import UIKit

class HomePageViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogoutClick () {
//        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AuthNavigationController") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false,completion:nil)
    }
}
