//
//  DateFormatterHelper.swift
//  NotesList
//
//  Created by Yehor Kyrylov on 12.08.2021.
//

import Foundation

class DateFormatterHelper {
    
    static private let dateFormatter = DateFormatter()
    static private let dateFormat = "MMM d, hh:mm"
    
    static func convertDateToString(date: Date) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
