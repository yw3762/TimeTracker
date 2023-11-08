//
//  ViewModel.swift
//  TimeTracking
//
//  Created by Alex Wang on 11/6/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    // Init Data
    static let focusInitDatas = [
        FocusInitData(name: "Study", iconName: "pencil.and.scribble"),
        FocusInitData(name: "Work", iconName: "laptopcomputer"),
        FocusInitData(name: "Project", iconName: "keyboard.fill"),
        FocusInitData(name: "Read", iconName: "book"),
        FocusInitData(name: "Cook", iconName: "frying.pan"),
        FocusInitData(name: "Entertainment", iconName: "arcade.stick.console"),
        FocusInitData(name: "Resting", iconName: "powersleep"),
    ]
    
    struct FocusInitData {
        private(set) var name: String
        private(set) var iconName: String
        
        init(name: String) {
            self.name = name
            self.iconName = ""
        }
        
        init(name: String, iconName: String) {
            self.name = name
            self.iconName = iconName
        }
    }
    
    static func createFocusFromData(data: FocusInitData) -> Model<FocusInitData>.Focus {
        return Model<FocusInitData>.Focus(name: data.name, iconName: data.iconName, timeIntervals: [], onFocus: false)
    }
    
    // Interchanging data with model and presenting data to view
    
    @Published var model: Model<FocusInitData> = Model(focusDatas: focusInitDatas, focusFactory: createFocusFromData)
    
    var focuses: Array<FocusPresentData> {
        return model.focusList.map { item in
            return FocusPresentData(
                name: item.name,
                iconName: item.iconName,
                elapsedTime: item.totalTimeUntilLastCompletedSession,
                lastStartedTime: item.timeIntervals.last!.startTime
            )
        }
    }
    
    func chooseFocus(name focusName: String) {
        model.chooseFocus(ViewModel.createFocusFromData(data: FocusInitData(name: focusName)))
    }
    
    struct FocusPresentData {
        private var name: String
        private var iconName: String
        private var elapsedTime: TimeMS
        private var lastStartedTime: TimeMS
        
        init(name: String, iconName: String, elapsedTime: TimeMS, lastStartedTime: TimeMS) {
            self.name = name
            self.iconName = iconName
            self.elapsedTime = elapsedTime
            self.lastStartedTime = lastStartedTime
        }
    }
}

