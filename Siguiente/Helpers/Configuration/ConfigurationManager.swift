//
//  ConfigurationManager.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/26/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

class ConfigurationManager {

    static let shared = ConfigurationManager()
    private var loginHelper = LoginHelper()
    private var eventsHelper = EventsHelper()
    
    private init() {
    }
    
    var keepCurrentEventTime: Int {
        get {
            return UserDefaults.standard.integer(forKey: "keepCurrent")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "keepCurrent")
        }
    }
    
    var startAtLogin: Bool {
        get {
            return loginHelper.loginEnabled()
        }
        set {
            loginHelper.setLoginEnabled(newValue)
        }
    }
    
    var searchEventsUntil: TimeOfDay {
        get {
            return eventsHelper.searchEventValue()
        }
        set {
            eventsHelper.setSearchEventValue(newValue)
        }
    }
}
