//
//  CalendarMonitor.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/20/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Cocoa
import EventKit

protocol CalendarMonitorDelegate: class {
    func noEventRestDay()
    func nextEvent(_ appointment: Appointment)
    func noAuthorization()
}

class CalendarMonitor {
    var eventStore: EKEventStore
    weak var delegate:CalendarMonitorDelegate?
    var timer: Timer?
    let interval: Double =  60
    var authorized: Bool = false
    
    init() {
        self.eventStore = EKEventStore()
        checkAuthorization()
    }
    
    func checkAuthorization() {
        switch EKEventStore.authorizationStatus(for: .event) {
            case .authorized:
                authorized = true
            case .denied:
                authorized = false
            case .notDetermined:
                eventStore.requestAccess(to: .event,
                                         completion: { [weak self] (granted: Bool, error: Error?) -> Void in
                      if granted {
                        self?.authorized = true
                        self?.checkNextEvent()
                      } else {
                        self?.authorized = false
                      }
                })
            default:
                authorized = false
        }
    }
    
    func startMonitoring() {
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(checkNextEvent),
                                     userInfo: nil,
                                     repeats: true)
        checkNextEvent()
    }
    
    func stopMonitoring() {
        timer?.invalidate()
    }
    
    @objc
    func checkNextEvent() {
        guard authorized else {
            delegate?.noAuthorization()
            return
        }
        
        if let next = getNextEvent() {
            let factory = AppointmentBuilder()
            let appointment = factory.appointmentFromEvent(next)
            delegate?.nextEvent(appointment)
        } else {
            delegate?.noEventRestDay()
        }
    }
    
    func getNextEvent() -> EKEvent? {
        let startDate = getStartDate()
        let endDate:Date
        switch ConfigurationManager.shared.searchEventsUntil {
        case .SixPM:
            endDate = Date().todaySixPM
        case .EightPM:
            endDate = Date().todayEightPM
        default:
            endDate = Date().endOfDay
        }
        
        var predicate: NSPredicate? = nil
        
        if let startDate = startDate {
            predicate = eventStore.predicateForEvents(withStart: startDate,
                                                      end: endDate,
                                                      calendars: nil)
        }
        
        var events: [EKEvent]? = nil
        if let aPredicate = predicate {
            events = eventStore.events(matching: aPredicate)
            
            if let events = events {
    
                return priorizeEvents(events)
            }
        }
        
        return nil
    }
    
    func getStartDate() -> Date? {
        let calendar = Calendar.current
        
        var previousComponent = DateComponents()
        previousComponent.minute = -15
        
        return calendar.date(byAdding: previousComponent,
                             to: Date())
    }
    
    func priorizeEvents(_ events: [EKEvent]) -> EKEvent? {
        if let startTime = events.first?.startDate {
            let timeSinceStart = startTime.distance(to: Date())
            let definedTime = ConfigurationManager.shared.keepCurrentEventTime
            
            if timeSinceStart < Double(definedTime) * 60.0 {
                return events.first
            } else if events.count >= 2 {
                return events[1]
            }
        }
        
        return nil
    }
}
