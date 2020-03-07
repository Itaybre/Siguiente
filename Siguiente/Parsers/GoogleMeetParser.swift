//
//  GoogleMeetParser.swift
//  Siguiente
//
//  Created by Itay Brenner on 2/26/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

class GoogleMeetParser: Parser {
    private static let regexPattern: String = "https:\\/\\/meet.google.com\\/([a-z]){3}-([a-z]){4}-([a-z]){3}"
    private static let descriptorSeparator: String = "-::~:~::~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~:~::~:~::-"
    
    func parseForURL(_ notes: String?) -> URL? {
        guard let description = notes else {
            return nil
        }
        
        let regex = try? NSRegularExpression(pattern: GoogleMeetParser.regexPattern,
                                             options: [])
        let range = NSRange(description.startIndex..<description.endIndex,
                            in: description)
        if let match = regex!.firstMatch(in: description,
                                         options: [],
                                         range: range) {
            if let urlRange = Range(match.range, in: description) {
                return URL(string: String(description[urlRange]))
            }
        }
        
        return nil
    }
    
    func eventDescription(_ notes: String?) -> String? {
        return notes?.components(separatedBy: GoogleMeetParser.descriptorSeparator).first
    }
}
