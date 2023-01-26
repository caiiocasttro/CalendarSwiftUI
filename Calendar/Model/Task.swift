//
//  Task.swift
//  Calendar
//
//  Created by Caio Chaves on 24.01.23.
//

import SwiftUI

// Task Model and Sample Tasks...
// Array of Tasks...
struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}
// Total Task Meta View...
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}
// Sample date for testing...
func getSampleDate(offset: Int) -> Date {
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var tasks: [TaskMetaData] = [

    TaskMetaData(task: [Task(title: "Meeting "),
    Task(title: "Vacation "), Task(title: "Party ")], taskDate: getSampleDate(offset: 1)),
    TaskMetaData(task: [Task(title: "Shopping ")], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [Task(title: "Doctor ")], taskDate: getSampleDate(offset: -8)),
    TaskMetaData(task: [Task(title: "Test ")], taskDate: getSampleDate(offset: 10)),
    TaskMetaData(task: [Task(title: "Birthday ")], taskDate: getSampleDate(offset: -22)),
    TaskMetaData(task: [Task(title: "Meeting ")], taskDate: getSampleDate(offset: 15)),
    TaskMetaData(task: [Task(title: "Meeting ")], taskDate: getSampleDate(offset: -20))]
