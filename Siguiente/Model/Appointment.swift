//
//  Appointment.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/22/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import EventKit

struct Appointment {
    let name: String
    let date: Date
    let eventId: String?
    let description: String?
    let meetURL: URL?
}
