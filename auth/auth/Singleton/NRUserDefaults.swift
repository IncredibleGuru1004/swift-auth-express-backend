//
//  NRUserDefaults.swift
//  auth
//
//  Created by mac on 30.08.2024.
//

import Foundation
import UIKit

class NRUserDefaults {
    static let shared = NRUserDefaults()
    
    func saveUser (userName: String) {
        let defaults = UserDefaults.standard
        defaults.set(userName, forKey:"")
        defaults.synchronize()
    }
    func getUser () -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "")
    }
}
