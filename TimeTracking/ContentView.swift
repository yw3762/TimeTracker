//
//  ContentView.swift
//  TimeTracking
//
//  Created by Alex Wang on 11/2/23.
//

import SwiftUI

let myHeight: CGFloat = 300
let myWidth: CGFloat = 300


struct ContentView: View {
    @ObservedObject public var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            List {
                // TODO: Fix directly accessing model data, access data / publish change via VM
                ForEach(1..<viewModel.model.focusList.count) { index in
                    HStack {
                        HStack() {
                            SelectButtonView(selected: viewModel.model.focusList[index].onFocus)
                            Image(systemName: ViewModel.focusInitDatas[index-1].iconName)
                                .frame(width: 25, height: 18)
                            Text(viewModel.model.focusList[index].name)
                        }
                        .frame(width: myWidth * 2 / 3, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.chooseFocus(name: viewModel.model.focusList[index].name)
                        }
                        Text(String(viewModel.model.focusList[index].totalTimeUntilLastCompletedSession.hourMinuteSecond))
                            .frame(alignment: .trailing)
                    }
                }
                .padding(5)
            }
        }
        .frame(width: myWidth, height: myHeight)
    }
}

struct SelectButtonView: View {
    var selected: Bool
    var body: some View {
        ZStack {
            Circle()
                .stroke(.blue, lineWidth: 2)
                .frame(width:18, height:18)
            if (selected) {
                Circle()
                    .fill(Color.blue)
                    .frame(width:14, height:14)
            }
        }
    }
}


#Preview {
    ContentView()
}
