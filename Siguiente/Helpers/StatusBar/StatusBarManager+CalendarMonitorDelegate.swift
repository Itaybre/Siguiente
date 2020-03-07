//
//  StatusBarManager+CalendarMonitorDelegate.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/3/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Cocoa

extension StatusBarManager: CalendarMonitorDelegate {
    func noEventRestDay() {
        currentAppointment = nil
        DispatchQueue.main.async {
            self.statusBarItem.button?.title = "No more events"
            self.rebuildMenu()
        }
    }
    
    func nextEvent(_ appointment: Appointment) {
        var time = remainingTime(appointment.date)
        var text = ""
        if time < 0 {
            text = "\(appointment.name) now"
        } else {
            time = time/60
            let hour = time > 60
            var timeString = "minutes"
            if hour {
                time = time/60
                timeString = (time == 1) ? "hour" : "hours"
            } else if time == 1 {
                timeString = "minute"
            }
            
            text = "\(appointment.name) in \(time) \(timeString)"
        }
        currentAppointment = appointment
        DispatchQueue.main.async {
            self.statusBarItem.button?.title = text
            self.rebuildMenu()
        }
    }
    
    func noAuthorization() {
        DispatchQueue.main.async {
            self.statusBarItem.button?.title = "No calendar permissions"
        }
    }
    
    private func remainingTime(_ date: Date) -> Int {
        return Int(date.timeIntervalSince(Date()))
    }
}
