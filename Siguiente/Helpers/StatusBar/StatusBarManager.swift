//
//  StatusBarManager.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/24/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Cocoa

@objc
protocol EmptyMenuTarget: class {
    @objc func quit()
}

@objc
protocol MenuTarget: class {
    @objc func quit()
    @objc func toggleLogin()
    @objc func openCalendar()
    @objc func showTimeSelected(sender: NSMenuItem)
    @objc func connectToMeeting()
    @objc func searchEventsUntilSelected(sender: NSMenuItem)
}

class StatusBarManager {
    var statusBarItem: NSStatusItem!
    var calendarMonitor: CalendarMonitor!
    var currentAppointment: Appointment?
    
    init() {
        statusBarItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.variableLength)
        calendarMonitor = CalendarMonitor()
        calendarMonitor.delegate = self
        
        buildEmptyMenu()
        calendarMonitor.startMonitoring()
    }
    
    func rebuildMenu() {
        buildMenuForAppointment(currentAppointment)
    }
    
    func buildEmptyMenu() {
        statusBarItem.menu = EmptyMenuBuilder().buildMenu(self)
    }
    
    func buildMenuForAppointment(_ appointment: Appointment?) {
        statusBarItem.menu = MenuBuilder().buildMenu(self, appointment)
    }
}
