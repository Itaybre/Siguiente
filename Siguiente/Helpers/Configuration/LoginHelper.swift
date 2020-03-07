//
//  LoginHelper.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/3/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Cocoa
import ServiceManagement

class LoginHelper {
    func loginEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "login")
    }
    
    func setLoginEnabled(_ enabled: Bool) {
        let success = SMLoginItemSetEnabled("com.itaysoft.Siguiente.Helper" as CFString, enabled)
        if success {
            UserDefaults.standard.set(enabled, forKey: "login")
        }
    }
}
