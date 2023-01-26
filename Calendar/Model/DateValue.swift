//
//  DateValue.swift
//  Calendar
//
//  Created by Caio Chaves on 24.01.23.
//

import SwiftUI

// Date Value Model...

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
