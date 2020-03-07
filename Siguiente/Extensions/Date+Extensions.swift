//
//  Date+Extensions.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/22/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import EventKit

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
    
    var todaySixPM: Date {
        return Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!
    }
    
    var todayEightPM: Date {
        return Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
    }
}
