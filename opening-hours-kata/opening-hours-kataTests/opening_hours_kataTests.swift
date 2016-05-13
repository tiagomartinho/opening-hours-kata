import XCTest
@testable import opening_hours_kata

class opening_hours_kataTests: XCTestCase {
    func testExample() {
        let openingDays: [Day] = [.Monday, .Wednesday, .Friday]
        let openingHours = Shift(openingHour: "08:00", closingHour: "16:00")
        let shop = Shop(openingDays: openingDays, openingHours: openingHours)

        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = 2016
        components.month = 05
        components.day = 11
        components.hour = 12
        components.minute = 22
        components.second = 11
        let wednesday = calendar?.dateFromComponents(components)

        XCTAssert(shop.isOpenOn(wednesday!))
    }
}

enum Day {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
}

struct Shift {
    let openingHour: String
    let closingHour: String
}

class Shop {
    let openingDays: [Day]
    let openingHours: Shift

    init(openingDays: [Day], openingHours: Shift) {
        self.openingDays = openingDays
        self.openingHours = openingHours
    }

    func isOpenOn(date: NSDate) -> Bool {
        return true
    }

    func nextOpeningDate() -> NSDate {
        return NSDate()
    }
}