//
//  StatusBarManager+MenuTarget.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/3/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Cocoa

extension StatusBarManager: MenuTarget {
    
    @objc
    internal func showTimeSelected(sender: NSMenuItem) {
        ConfigurationManager.shared.keepCurrentEventTime = sender.tag
        rebuildMenu()
        calendarMonitor.checkNextEvent()
    }
    
    @objc
    internal func openCalendar() {
        if let identifier = self.currentAppointment?.eventId,
            let url = URL(string: "ical://ekevent/\(identifier)"),
            NSWorkspace.shared.open(url) {
        }
    }
    
    @objc
    internal func toggleLogin() {
        ConfigurationManager.shared.startAtLogin.toggle()
        rebuildMenu()
    }
    
    @objc
    internal func connectToMeeting() {
        if let url = self.currentAppointment?.meetURL,
            NSWorkspace.shared.open(url) {
        }
    }
    
    @objc
    internal func searchEventsUntilSelected(sender: NSMenuItem) {
        ConfigurationManager.shared.searchEventsUntil = TimeOfDay(rawValue: sender.tag)!
        rebuildMenu()
        calendarMonitor.checkNextEvent()
    }
}
