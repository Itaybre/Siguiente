//
//  EmptyMenuBuilder.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/3/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Cocoa

class EmptyMenuBuilder: NSObject {
    func buildMenu(_ target: EmptyMenuTarget) -> NSMenu {
        let mainMenu = NSMenu()
        mainMenu.addItem(buildCloseItem(target))
        
        return mainMenu
    }
    
    func buildCloseItem(_ target: EmptyMenuTarget) -> NSMenuItem {
        let closeItem = NSMenuItem()
        closeItem.title = "Quit"
        closeItem.target = target
        closeItem.action = #selector(EmptyMenuTarget.quit)
        
        return closeItem
    }
}
