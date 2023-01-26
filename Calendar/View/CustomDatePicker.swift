//
//  CustomDatePicker.swift
//  Calendar
//
//  Created by Caio Chaves on 24.01.23.
// MARK: Continue in 13:13 --

import SwiftUI

struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    // Month update on arrow button clicks...
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack(spacing: 35) {
            let days: [String] = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
            // Days...
            HStack(spacing: 20) {
                VStack(alignment: .leading ,spacing: 10) {
                    
//                    Text(extraDate()[0])
//                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                    
                    HStack() {
                        Text(extraDate()[0])
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Spacer()
                        Button {
                            withAnimation {
                                currentMonth -= 1
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        Button {
                            withAnimation {
                                currentMonth += 1
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .foregroundColor(.black)
                                
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            .padding(.top)
            // Day view...
            
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            // Dates..
            // LazyVgrid..
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                        .background(
                        Capsule()
                            .fill(Color("Pink"))
                            .padding(.horizontal, 8)
                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)).onTapGesture {
                                currentDate = value.date
                                
                            }
                }
            }
            VStack(spacing: 20) {
                Text("Tasks")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }){
                    ForEach(task.task) { task in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(task.time
                                .addingTimeInterval(CGFloat .random(in: 0...5000)), style: .time)
                            
                            Text(task.title)
                                .font(.system(size: 16))
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("Green").opacity(0.3).cornerRadius(10))
                    }
                } else {
                    Text("No Task Found")
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical)
        }
        .background(Color("Pink").opacity(0.1))
        .cornerRadius(10)
        .frame(width: 342)
        .onChange(of: currentMonth) { newValue in
            // updating month...
            currentDate = getCurrentMonth()
        }
    }
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Pink"))
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        
                    Spacer()
                }
            }
        }
        .padding(.vertical,8)
        .frame(height: 60, alignment: .top)
    }
    
    func isSameDay(date1: Date, date2: Date ) -> Bool {
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    // Extrating year and month for display..
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: "")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting current month date...
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func extractDate() -> [DateValue]{
        
        let calendar = Calendar.current
        
        // Getting current month date...
         let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            // Getting day...
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        // adding offset to get exact week days...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Extending date to get current month dates

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
    // Getting start date...
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        
        // Getting date...
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 , to: startDate)!
        }
    }
}
