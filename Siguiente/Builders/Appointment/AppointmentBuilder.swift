//
//  AppointmentFactory.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/22/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import EventKit

class AppointmentBuilder {
    let googleParser = GoogleMeetParser()
    
    func appointmentFromEvent(_ event: EKEvent) -> Appointment {
        var name = event.title ?? "No Name"
        if name.count == 0 {
            name = "No Name"
        }
        
        let date = event.startDate ?? Date.init(timeIntervalSince1970: 0)
        let url = googleParser.parseForURL(event.notes)
        let description = googleParser.eventDescription(event.notes)
        let eventId = event.eventIdentifier
        
        return Appointment(name: name,
                           date: date,
                           eventId: eventId,
                           description: description,
                           meetURL: url)
    }
}
