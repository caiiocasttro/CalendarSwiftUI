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

    TaskMetaData(task: [Task(title: "Meeting 1"),
    Task(title: "Meeting 2"), Task(title: "Meeting 3")], taskDate: getSampleDate(offset: 1)),
    TaskMetaData(task: [Task(title: "Meeting 4")], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [Task(title: "Meeting 5")], taskDate: getSampleDate(offset: -8)),
    TaskMetaData(task: [Task(title: "Meeting 6")], taskDate: getSampleDate(offset: 10)),
    TaskMetaData(task: [Task(title: "Meeting 7")], taskDate: getSampleDate(offset: -22)),
    TaskMetaData(task: [Task(title: "Meeting 8")], taskDate: getSampleDate(offset: 15)),
    TaskMetaData(task: [Task(title: "Meeting 9")], taskDate: getSampleDate(offset: -20))]
