//
//  SearchEventsHelper.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/7/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

class EventsHelper {
    func searchEventValue() -> TimeOfDay {
        return TimeOfDay(rawValue: UserDefaults.standard.integer(forKey: "timeOfDay"))!
    }
    
    func setSearchEventValue(_ value: TimeOfDay) {
        UserDefaults.standard.set(value.rawValue, forKey: "timeOfDay")
    }
}
