//
//  Model.swift
//  TimeTracking
//
//  Created by Alex Wang on 11/6/23.
//

import Foundation
import Collections

/**
 * Model captures a list of all possible things to focus on (called 'Focus') and the start/end time of user's selection of focus
 * called 'FocusSession'.
 */
struct Model<FocusData> {
    // TODO: disallow focus name with '%' character
    private let noFocus = "%void"
    private let noFocusIdx: Int
    var focusList: Array<Focus>
    var currentFocusIdx: Int
    var focusSessions: [TimeMS: FocusSession]
    
    init(focusDatas: [FocusData], focusFactory: (FocusData) -> Focus) {
        focusList = [Focus(name: noFocus, timeIntervals: [TimeInterval(startTime: 0)], onFocus: true)]
        noFocusIdx = 0
        for focusData in focusDatas {
            focusList.append(focusFactory(focusData))
        }
        currentFocusIdx = 0
        focusSessions = [0:FocusSession(time: TimeInterval(startTime: 0), focusIndex: noFocusIdx)]
    }
    
    func getFocusIndex(of focus: Focus) -> Int? {
        for idx in 0..<focusList.count {
            if (focus == focusList[idx]) {
                return idx
            }
        }
        return nil
    }
    
    mutating func chooseFocus(_ focus: Focus) {
        // When switch from focus A to B, do the following:
        // 1. Check current ms, log it into endTime of A (in both focusSessions and focusList), calculate accumulated time for session A
        // 2. Check current ms, log it as the startTime of B (in both focusSessions and focusList)
        // 3. switch currentFocusIdx from idx of session A to session B
        // 4. set the last focusSession of focusSessions to terminate and add a new session at current timestamp
        
        // Find the index of focus we are trying to choose
        
        guard var targetFocusIdx = getFocusIndex(of: focus) else {
            // targetFocus is not present in focusList
            print("targetFocus is not present in focusList")
            return
        }
        
        // If targetFocus is currentFocus, then switch current focus to no focus
        if (targetFocusIdx == currentFocusIdx) {
            targetFocusIdx = noFocusIdx
        }
        
        print("------------------------ Trying to change focus ------------------------")
        print("Current focus is: ", focusList[currentFocusIdx])
        print("\n")
        print("Changing to the following focus:", focusList[targetFocusIdx])
        print("\n")
        
        let currTimeMS = Date().millisecondsSince1970
        
        let lastFocusIdx = currentFocusIdx
        currentFocusIdx = targetFocusIdx
        focusList[currentFocusIdx].onFocus = true
        focusList[lastFocusIdx].onFocus = false
        
        // log entTime of lastFocusIdx in focusList
        focusList[lastFocusIdx].setLastTimeInterval(to: currTimeMS)
        
        
        // log entTime of lastFocusIdx in focusSessions
        guard let lastStartTimeMS = focusList[lastFocusIdx].getLastStartTime() else {
            print("No LastStartTime")
            return
        }
        
        if (focusSessions[lastStartTimeMS] == nil) {
            print("No lastFocusSession found")
            return
        }
        
        focusSessions[lastStartTimeMS]!.time.endTime = currTimeMS
        
        // TODO: update accumulated time for session A
        if (lastFocusIdx != noFocusIdx) {
            focusList[lastFocusIdx].totalTimeUntilLastCompletedSession += currTimeMS - lastStartTimeMS
        }
        
        // log startTime of currentFocusIdx in focusList
        focusList[currentFocusIdx].timeIntervals.append(TimeInterval(startTime: currTimeMS))
        
        // log startTime of currentFocusIdx in focusSessions
        focusSessions[currTimeMS] = FocusSession(time: TimeInterval(startTime: currTimeMS), focusIndex: currentFocusIdx)
        
        print("------------------------ Done changing focus ------------------------")
        print("Previous focus was: ", focusList[lastFocusIdx])
        print("Current focus is: ", focusList[currentFocusIdx])
    }
    
    struct FocusSession {
        var time: TimeInterval
        var focusIndex: Int
    }
    
    struct Focus: Equatable {
        static func ==(lhs: Focus, rhs: Focus) -> Bool {
            return lhs.name == rhs.name
        }
        
        var name: String
        var iconName: String = ""
        var timeIntervals: Array<TimeInterval>
        var onFocus: Bool
        var totalTimeUntilLastCompletedSession: TimeMS = 0
        
        func getLastStartTime() -> TimeMS? {
            if timeIntervals.count < 1 {
                print("timeIntervals of the focus is empty")
                return nil
            }
            return timeIntervals[timeIntervals.count - 1].startTime
        }
        
        mutating func setLastTimeInterval(to time: TimeMS) {
            // TODO: Check does this actually mutate element in the array
            if timeIntervals.count < 1 {
                print("timeIntervals of the focus is empty")
                return
            }
            timeIntervals[timeIntervals.count - 1].setEndTime(time)
        }
    }
    
    struct TimeInterval {
        var startTime: TimeMS
        var endTime: TimeMS?
        
        mutating func setEndTime(_ time: TimeMS) {
            endTime = time
        }
    }
}
