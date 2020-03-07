//
//  StatusBarManager+EmptyMenuTarget.swift
//  Siguiente
//
//  Created by Itay Brenner on 3/3/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Cocoa

extension StatusBarManager: EmptyMenuTarget {
    @objc
    func quit() {
        NSApplication.shared.terminate(self)
    }
}
