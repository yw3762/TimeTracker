//
//  TestTimeMS.swift
//  TimeTrackingTests
//
//  Created by Alex Wang on 11/7/23.
//

import XCTest
@testable import TimeTracking

final class TestTimeMS: XCTestCase {
    var timeMS: TimeMS!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSecond() {
        timeMS = 5400
        XCTAssertEqual(timeMS.hourMinuteSecond, "0:00:05")
    }
    
    func testMinite() {
        timeMS = 59999
        XCTAssertEqual(timeMS.hourMinuteSecond, "0:00:59")
        timeMS = 60000
        XCTAssertEqual(timeMS.hourMinuteSecond, "0:01:00")
        timeMS = 60001
        XCTAssertEqual(timeMS.hourMinuteSecond, "0:01:00")
        timeMS = 61000
        XCTAssertEqual(timeMS.hourMinuteSecond, "0:01:01")
    }
    
    func testHour() {
        timeMS = 3600000
        XCTAssertEqual(timeMS.hourMinuteSecond, "1:00:00")
        timeMS = 3599999
        XCTAssertEqual(timeMS.hourMinuteSecond, "0:59:59")
        timeMS = 3601000
        XCTAssertEqual(timeMS.hourMinuteSecond, "1:00:01")
    }
    
    func testBigHours() {
        timeMS = 86400000
        XCTAssertEqual(timeMS.hourMinuteSecond, "24:00:00")
        timeMS = 3600000 * 25
        XCTAssertEqual(timeMS.hourMinuteSecond, "25:00:00")
        timeMS = 3600000 * 64
        XCTAssertEqual(timeMS.hourMinuteSecond, "64:00:00")
        timeMS = 3600000 * 99
        XCTAssertEqual(timeMS.hourMinuteSecond, "99:00:00")
        timeMS = 3600000 * 100
        XCTAssertEqual(timeMS.hourMinuteSecond, "100:00:00")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
