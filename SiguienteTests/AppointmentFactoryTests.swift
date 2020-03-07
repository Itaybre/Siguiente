//
//  AppointmentFactoryTests.swift
//  SiguienteTests
//
//  Created by Itay Brenner on 2/22/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import XCTest
import EventKit
@testable import Siguiente

class AppointmentFactoryTests: XCTestCase {

    func testWithURL() {
        let event = EKEvent()
        event.title = "Title 1"
        event.notes = """
-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
Please do not edit this section of the description.

This event has a video call.
Join: https://meet.google.com/mmk-geuj-pty
+55 21 4560-7277 PIN: 391323709#
View more phone numbers: https://tel.meet/mmk-gevj-pty?pin=9229934200637&hs=7
-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
"""
        event.startDate = Date(timeIntervalSince1970: 100)
        
        let factory = AppointmentBuilder()
        
        let appointment = factory.appointmentFromEvent(event)
        
        XCTAssertNotNil(appointment.meetURL)
        XCTAssertEqual(appointment.meetURL, URL(string: "https://meet.google.com/mmk-geuj-pty"))
        XCTAssertEqual(appointment.name, "Title 1")
        XCTAssertEqual(appointment.date, Date(timeIntervalSince1970: 100))
    }

    func testWitNohURL() {
            let event = EKEvent()
            event.title = "Title 2"
            event.notes = """
    -::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
    Please do not edit this section of the description.

    This event has a video call.
    +55 21 4560-7277 PIN: 391323709#
    View more phone numbers: https://tel.meet/mmk-gevj-pty?pin=9229934200637&hs=7
    -::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-
    """
            event.startDate = Date(timeIntervalSince1970: 120)
            
            let factory = AppointmentBuilder()
            
            let appointment = factory.appointmentFromEvent(event)
            
            XCTAssertNil(appointment.meetURL)
            XCTAssertEqual(appointment.name, "Title 2")
            XCTAssertEqual(appointment.date, Date(timeIntervalSince1970: 120))
    }
    
    func testWitNohotes() {
            let event = EKEvent()
            event.title = "Title 3"
            event.notes = nil
            event.startDate = Date(timeIntervalSince1970: 1000)
            
            let factory = AppointmentBuilder()
            
            let appointment = factory.appointmentFromEvent(event)
            
            XCTAssertNil(appointment.meetURL)
            XCTAssertEqual(appointment.name, "Title 3")
            XCTAssertEqual(appointment.date, Date(timeIntervalSince1970: 1000))
    }
    
    func testDefaultName() {
            let event = EKEvent()
            event.title = nil
            event.notes = nil
            event.startDate = Date(timeIntervalSince1970: 1000)
            
            let factory = AppointmentBuilder()
            
            let appointment = factory.appointmentFromEvent(event)
            
            XCTAssertNil(appointment.meetURL)
            XCTAssertEqual(appointment.name, "No Name")
            XCTAssertEqual(appointment.date, Date(timeIntervalSince1970: 1000))
    }
    
    func testDefaultDate() {
            let event = EKEvent()
            event.title = nil
            event.notes = nil
            event.startDate = nil
            
            let factory = AppointmentBuilder()
            
            let appointment = factory.appointmentFromEvent(event)
            
            XCTAssertNil(appointment.meetURL)
            XCTAssertEqual(appointment.name, "No Name")
            XCTAssertEqual(appointment.date, Date.init(timeIntervalSince1970: 0))
    }
}
