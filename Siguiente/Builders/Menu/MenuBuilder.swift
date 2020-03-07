//
//  MenuBuilder.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/3/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Cocoa

class MenuBuilder: NSObject {
    func buildMenu(_ target: MenuTarget, _ appointment: Appointment?) -> NSMenu {
        let mainMenu = NSMenu()
        
        if let appointment = appointment {
            if appointment.meetURL != nil {
                mainMenu.addItem(buildJoinItem(target, appointment))
            } else {
                mainMenu.addItem(buildNoLinkFoundItem(target, appointment))
            }
            mainMenu.addItem(buildCalendarItem(target))
            mainMenu.addItem(NSMenuItem.separator())
        }
        
        let showItem = buildShowItem()
        mainMenu.addItem(showItem)
        mainMenu.setSubmenu(buildSelectPreviousTimeItem(target), for: showItem)
        
        let showEvents = buildShowEventUntil()
        mainMenu.addItem(showEvents)
        mainMenu.setSubmenu(buildSelectShowUntil(target), for: showEvents)
        
        mainMenu.addItem(buildLoginItem(target))
        mainMenu.addItem(NSMenuItem.separator())
        mainMenu.addItem(buildCloseItem(target))
        
        return mainMenu
    }
    
    private func buildJoinItem(_ target: MenuTarget,_ appointment: Appointment?) -> NSMenuItem {
        let openItem = NSMenuItem()
        openItem.title = "Join Meeting"
        openItem.toolTip = appointment?.description
        openItem.target = target
        openItem.action = #selector(MenuTarget.connectToMeeting)
        
        return openItem
    }
    
    private func buildNoLinkFoundItem(_ target: MenuTarget,_ appointment: Appointment?) -> NSMenuItem {
        let noLinkFound = NSMenuItem()
        noLinkFound.title = "No link found"
        noLinkFound.toolTip = appointment?.description
        
        return noLinkFound
    }
    
    private func buildCalendarItem(_ target: MenuTarget) -> NSMenuItem {
        let calendarItem = NSMenuItem()
        calendarItem.title = "Open in Calendar"
        calendarItem.target = target
        calendarItem.action = #selector(MenuTarget.openCalendar)
        
        return calendarItem
    }
    
    private func buildShowItem() -> NSMenuItem {
        let currentItem = NSMenuItem()
        currentItem.title = "Show connect"
        
        return currentItem
    }
    
    private func buildShowEventUntil() -> NSMenuItem {
        let currentItem = NSMenuItem()
        currentItem.title = "Show events until"
        
        return currentItem
    }
    
    private func buildLoginItem(_ target: MenuTarget) -> NSMenuItem {
        let login = NSMenuItem()
        login.title = "Start at Login"
        login.state = ConfigurationManager.shared.startAtLogin ? .on : .off
        login.target = target
        login.action = #selector(MenuTarget.toggleLogin)
        
        return login
    }
    
    private func buildCloseItem(_ target: MenuTarget) -> NSMenuItem {
        let closeItem = NSMenuItem()
        closeItem.title = "Quit"
        closeItem.target = target
        closeItem.action = #selector(MenuTarget.quit)
        
        return closeItem
    }
    
    private func buildSelectPreviousTimeItem(_ target: MenuTarget) -> NSMenu {
        let currentValue = ConfigurationManager.shared.keepCurrentEventTime
        
        let zero = NSMenuItem()
        zero.title = "Don't show"
        zero.state = currentValue == 0 ? .on : .off
        zero.target = target
        zero.action = #selector(MenuTarget.showTimeSelected(sender:))
        zero.tag = 0
        
        let menu = NSMenu()
        menu.addItem(zero)
        
        for element in [5, 10, 15, 30] {
            let item = NSMenuItem()
            item.title = "\(element) minutes"
            item.state = currentValue == element ? .on : .off
            item.target = target
            item.action = #selector(MenuTarget.showTimeSelected(sender:))
            item.tag = element
            
            menu.addItem(item)
        }
        
        return menu
    }
    
    private func buildSelectShowUntil(_ target: MenuTarget) -> NSMenu {
        let currentValue = ConfigurationManager.shared.searchEventsUntil
        
        let endOfDay = NSMenuItem()
        endOfDay.title = "End of day"
        endOfDay.state = currentValue == TimeOfDay.EndOfDay ? .on : .off
        endOfDay.target = target
        endOfDay.action = #selector(MenuTarget.searchEventsUntilSelected(sender:))
        endOfDay.tag = TimeOfDay.EndOfDay.rawValue
        
        let menu = NSMenu()
        
        for element in [TimeOfDay.SixPM, TimeOfDay.EightPM] {
            let item = NSMenuItem()
            item.title = "\(element.rawValue) PM"
            item.state = currentValue == element ? .on : .off
            item.target = target
            item.action = #selector(MenuTarget.searchEventsUntilSelected(sender:))
            item.tag = element.rawValue
            
            menu.addItem(item)
        }
        
        menu.addItem(endOfDay)
        
        return menu
    }
}
