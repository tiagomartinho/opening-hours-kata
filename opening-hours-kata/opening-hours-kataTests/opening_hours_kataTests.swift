import XCTest
@testable import opening_hours_kata

class opening_hours_kataTests: XCTestCase {

    func testIfDateIsOnOpeningRangeShopIsOpen() {
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

    func testIfDateIsNotOnOpeningDayShopIsClosed() {
        let openingDays: [Day] = [.Monday, .Wednesday, .Friday]
        let openingHours = Shift(openingHour: "08:00", closingHour: "16:00")
        let shop = Shop(openingDays: openingDays, openingHours: openingHours)

        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = 2016
        components.month = 05
        components.day = 12
        components.hour = 12
        components.minute = 22
        components.second = 11
        let thursday = calendar?.dateFromComponents(components)

        XCTAssertFalse(shop.isOpenOn(thursday!))
    }

    func testIfDateIsNotOnOpeningHourShopIsClosed() {
        let openingDays: [Day] = [.Monday, .Wednesday, .Friday]
        let openingHours = Shift(openingHour: "08:00", closingHour: "16:00")
        let shop = Shop(openingDays: openingDays, openingHours: openingHours)

        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = 2016
        components.month = 05
        components.day = 11
        components.hour = 20
        components.minute = 22
        components.second = 11
        let thursday = calendar?.dateFromComponents(components)

        XCTAssertFalse(shop.isOpenOn(thursday!))
    }
}

enum Day: Int {
    case Sunday = 1, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

struct Shift {
    let openingHour: Time
    let closingHour: Time

    init(openingHour: String, closingHour: String) {
        let openingHourComponents = openingHour.componentsSeparatedByString(":")
        let closingHourComponents = closingHour.componentsSeparatedByString(":")
        self.openingHour = Time(hour: Int(openingHourComponents[0])!, minute: Int(openingHourComponents[1])!)
        self.closingHour = Time(hour: Int(closingHourComponents[0])!, minute: Int(closingHourComponents[1])!)
    }
}

struct Time {
    let hour: Int
    let minute: Int
}

extension Time: Comparable, Equatable {
}

func ==(lhs: Time, rhs: Time) -> Bool {
    return lhs.hour == rhs.hour
}

func <(lhs: Time, rhs: Time) -> Bool {
    return lhs.hour < rhs.hour || (lhs.hour == rhs.hour && lhs.minute < rhs.minute)
}

class Shop {
    let openingDays: [Day]
    let shift: Shift

    init(openingDays: [Day], openingHours: Shift) {
        self.openingDays = openingDays
        self.shift = openingHours
    }

    func isOpenOn(date: NSDate) -> Bool {
        let weekday = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(.Weekday, fromDate: date).weekday
        let isOnOpeningDay = openingDays.contains(Day(rawValue: weekday)!)
        let dateHour = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(.Hour, fromDate: date).hour
        let dateMinute = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.components(.Minute, fromDate: date).minute
        let dateTime = Time(hour: dateHour, minute: dateMinute)
        let isOnOpeningHour =  dateTime >= shift.openingHour && dateTime <= shift.closingHour
        return isOnOpeningDay && isOnOpeningHour
    }

    func nextOpeningDate() -> NSDate {
        return NSDate()
    }
}