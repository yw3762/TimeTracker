//
//  ContentView.swift
//  TimeTracking
//
//  Created by Alex Wang on 11/2/23.
//

import SwiftUI

extension TimeInterval {
    var hourMinuteSecond: String {
        String(format:"%d:%02d:%02d", hour, minute, second)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}


struct UserFocus: Identifiable {
    let name: String
    let id = UUID()
    let timeElapsed: TimeInterval = 0
}


private var userFocuses = [
    UserFocus(name: "Read"),
    UserFocus(name: "Work"),
    UserFocus(name: "Study"),
    UserFocus(name: "Cook"),
    UserFocus(name: "Entertainment"),
    UserFocus(name: "Inactive"),
]


struct ListItemView: View {
    @State private var select = false
    var activity = false
    let focus: UserFocus
    var body: some View {
        HStack {
            Toggle(focus.name, isOn: $select)
                .toggleStyle(.checklist)
            Spacer()
            Text(focus.timeElapsed.hourMinuteSecond)
        }
        .padding(.vertical, 4)
    }
}

extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checklist: CheckboxToggleStyle { .init() }
}

struct CheckboxToggleStyle: ToggleStyle {
   func makeBody(configuration: Configuration) -> some View {
       HStack {
           Circle()
               .stroke(lineWidth: 2)
               .frame(width: 18, height: 18)
               .overlay {
                   Image(systemName: configuration.isOn ?"checkmark" : "")
               }
               .onTapGesture {
                   withAnimation(.spring()) {
                       configuration.isOn.toggle()
                   }
               }
           configuration.label
           
       }
   }
}


struct ContentView: View {
    @State private var selection: Int = -1
    var body: some View {
        VStack {
            List(userFocuses) { focus in
                ListItemView(focus: focus)
            }
        }
        .frame(width: myWidth, height: myHeight)
    }
}

#Preview {
    ContentView()
}
