//
//  Parser.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/26/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

protocol Parser {
    func parseForURL(_ notes: String?) -> URL?
    func eventDescription(_ notes: String?) -> String?
}
