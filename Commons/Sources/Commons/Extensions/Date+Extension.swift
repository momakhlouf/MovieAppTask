//
//  File.swift
//  Commons
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
public extension Date{
    static let toString: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            return formatter
        }()
    
    var displayFormat: String {
        self.formatted(.dateTime.year())
    }
}

