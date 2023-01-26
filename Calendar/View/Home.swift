//
//  Home.swift
//  Calendar
//
//  Created by Caio Chaves on 24.01.23.
//

import SwiftUI

struct Home: View {
    
    @State var currentDate: Date = Date()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                // Custom date picker......
                CustomDatePicker(currentDate: $currentDate)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
