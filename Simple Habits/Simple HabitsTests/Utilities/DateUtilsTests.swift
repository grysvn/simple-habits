//
//  DateUtilsTests.swift
//  Simple HabitsTests
//
//  Created by Matthew Gray on 7/7/21.
//

import XCTest

@testable import Simple_Habits

class Date_RelativeFunctionsTests: XCTestCase {

    func testToGmtString() throws {
        let date = Date()
        let dayString = DateUtils.gmtDayString(from: Date())

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT")

        XCTAssertEqual(formatter.string(from: date), dayString)
    }

}
