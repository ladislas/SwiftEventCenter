//
//  EventManagerTests.swift
//  SwiftEventManager
//
//  Created by Ladislas de Toldi on 14/10/2018.
//

import Foundation
import XCTest

@testable import EventCenter

extension Event.Name {

	static let event = Event.Name("event")
	static let event1 = Event.Name("event1")
	static let event2 = Event.Name("event2")
	static let event3 = Event.Name("event3")

}

final class EventManagerTests: XCTestCase {

	func test_init() {

		let ec = EventCenter()

		XCTAssertEqual(ec.observers, [Event.Name: [ObserverStructure]]())
		XCTAssertTrue(ec.observers.isEmpty)

	}

	func test_addObserver_same_event() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}
		func eventHandler3(event: Event) {}

		ec.addObserver(forEvent: .event, callback: eventHandler1)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 1)

		ec.addObserver(forEvent: .event, callback: eventHandler2)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 2)

		ec.addObserver(forEvent: .event, callback: eventHandler3)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 3)

	}

	func test_addObserver_different_events() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}
		func eventHandler3(event: Event) {}

		ec.addObserver(forEvent: .event1, callback: eventHandler1)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event1]?.count, 1)
		XCTAssertNil(ec.observers[.event2])
		XCTAssertNil(ec.observers[.event3])

		ec.addObserver(forEvent: .event2, callback: eventHandler2)

		XCTAssertEqual(ec.observers.count, 2)
		XCTAssertEqual(ec.observers[.event1]?.count, 1)
		XCTAssertEqual(ec.observers[.event2]?.count, 1)
		XCTAssertNil(ec.observers[.event3])

		ec.addObserver(forEvent: .event3, callback: eventHandler3)

		XCTAssertEqual(ec.observers.count, 3)
		XCTAssertEqual(ec.observers[.event1]?.count, 1)
		XCTAssertEqual(ec.observers[.event2]?.count, 1)
		XCTAssertEqual(ec.observers[.event3]?.count, 1)

	}

	func test_removeObservers_forEvent() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}
		func eventHandler3(event: Event) {}

		ec.addObserver(forEvent: .event1, callback: eventHandler1)
		ec.addObserver(forEvent: .event2, callback: eventHandler2)
		ec.addObserver(forEvent: .event3, callback: eventHandler3)

		XCTAssertEqual(ec.observers.count, 3)

		ec.removeObservers(forEvent: .event1)

		XCTAssertEqual(ec.observers.count, 2)

		ec.removeObservers(forEvent: .event2)

		XCTAssertEqual(ec.observers.count, 1)

		ec.removeObservers(forEvent: .event3)

		XCTAssertEqual(ec.observers.count, 0)

		ec.addObserver(forEvent: .event, callback: eventHandler1)
		ec.addObserver(forEvent: .event, callback: eventHandler2)
		ec.addObserver(forEvent: .event, callback: eventHandler3)

		XCTAssertEqual(ec.observers.count, 1)

		ec.removeObservers(forEvent: .event)

		XCTAssertEqual(ec.observers.count, 0)

	}

	func test_removeObserver_with_different_names() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}
		func eventHandler3(event: Event) {}

		ec.addObserver(forEvent: .event, name: "obs1", callback: eventHandler1)
		ec.addObserver(forEvent: .event, name: "obs2", callback: eventHandler2)
		ec.addObserver(forEvent: .event, name: "obs3", callback: eventHandler3)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 3)

		ec.removeObserver(name: "obs1", forEvent: .event)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 2)

		ec.removeObserver(name: "obs2", forEvent: .event)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 1)

		ec.removeObserver(name: "obs3", forEvent: .event)

		XCTAssertEqual(ec.observers.count, 0)
		XCTAssertNil(ec.observers[.event])

	}

	func test_removeObserver_with_same_names() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}
		func eventHandler3(event: Event) {}

		ec.addObserver(forEvent: .event, name: "obs1", callback: eventHandler1)
		ec.addObserver(forEvent: .event, name: "obs1", callback: eventHandler2)
		ec.addObserver(forEvent: .event, name: "obs3", callback: eventHandler3)
		ec.addObserver(forEvent: .event, name: "obs1", callback: eventHandler2)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 4)

		ec.removeObserver(name: "obs1", forEvent: .event)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 1)

		ec.removeObserver(name: "obs3", forEvent: .event)

		XCTAssertEqual(ec.observers.count, 0)
		XCTAssertNil(ec.observers[.event])

	}

	func test_removeObserver_with_nil_name() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}
		func eventHandler3(event: Event) {}

		ec.addObserver(forEvent: .event, name: "obs1", callback: eventHandler1)
		ec.addObserver(forEvent: .event, callback: eventHandler2)
		ec.addObserver(forEvent: .event, callback: eventHandler3)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 3)

		ec.removeObserver(name: nil, forEvent: .event)

		XCTAssertEqual(ec.observers.count, 1)
		XCTAssertEqual(ec.observers[.event]?.count, 1)

		ec.removeObserver(name: "obs1", forEvent: .event)

		XCTAssertEqual(ec.observers.count, 0)
		XCTAssertNil(ec.observers[.event])

	}

	func test_removeAllObservers() {

		let ec = EventCenter()

		func eventHandler1(event: Event) {}
		func eventHandler2(event: Event) {}

		ec.addObserver(forEvent: .event, callback: eventHandler1)
		ec.addObserver(forEvent: .event, callback: eventHandler2)

		XCTAssertFalse(ec.observers.isEmpty)

		ec.removeAllObservers()

		XCTAssertEqual(ec.observers, [Event.Name: [ObserverStructure]]())
		XCTAssertTrue(ec.observers.isEmpty)

	}

	func test_post_event_without_object_without_userInfo() {

		let ec = EventCenter()
		var global: Int = 0

		func eventHandler1(event: Event) {
			global = 1
			print("GLOBAL IS NOW - \(global)")
		}
		func eventHandler2(event: Event) {
			global = 2
			print("GLOBAL IS NOW - \(global)")
		}

		ec.addObserver(forEvent: .event1, callback: eventHandler1)
		ec.addObserver(forEvent: .event2, callback: eventHandler2)

		ec.post(event: .event1)

		XCTAssertEqual(global, 1)

		ec.post(event: .event2)

		XCTAssertEqual(global, 2)

		ec.post(event: .event1)

		XCTAssertEqual(global, 1)

		ec.post(event: .event2)

		XCTAssertEqual(global, 2)

	}

	func test_post_event_with_object_without_userInfo() {

		let ec = EventCenter()
		var globalObject: String = ""

		func eventHandler1(event: Event) {
			if let value = event.object as? String {
				globalObject = value
				print("GLOBAL OBJ IS NOW - \(globalObject)")
			}
		}
		func eventHandler2(event: Event) {
			if let value = event.object as? String {
				globalObject = value
				print("GLOBAL OBJ IS NOW - \(globalObject)")
			}
		}

		ec.addObserver(forEvent: .event1, callback: eventHandler1)
		ec.addObserver(forEvent: .event2, callback: eventHandler2)

		ec.post(event: .event1, object: "val1")

		XCTAssertEqual(globalObject, "val1")

		ec.post(event: .event2, object: "val2")

		XCTAssertEqual(globalObject, "val2")

		ec.post(event: .event1, object: "val1")

		XCTAssertEqual(globalObject, "val1")

		ec.post(event: .event2, object: "val2")

		XCTAssertEqual(globalObject, "val2")

	}

	func test_post_event_with_object_with_userInfo() {

		let ec = EventCenter()
		var globalObject: String = ""
		var globalInfoNumerical: Int = 0
		var globalInfoString: String = ""

		func eventHandler1(event: Event) {
			if let value = event.object as? String {
				globalObject = value
				print("GLOBAL OBJ IS NOW - \(globalObject)")
			}
			if let info = event.userInfo {
				globalInfoNumerical = (info[42] as? Int)!
				print("GLOBAL INFO NUM IS NOW - \(globalInfoNumerical)")
				globalInfoString = (info["42"] as? String)!
				print("GLOBAL INFO STR IS NOW - \(globalInfoString)")
			}
		}
		func eventHandler2(event: Event) {
			if let value = event.object as? String {
				globalObject = value
				print("GLOBAL OBJ IS NOW - \(globalObject)")
			}
			if let info = event.userInfo {
				globalInfoNumerical = (info[42] as? Int)!
				print("GLOBAL INFO NUM IS NOW - \(globalInfoNumerical)")
				globalInfoString = (info["42"] as? String)!
				print("GLOBAL INFO STR IS NOW - \(globalInfoString)")
			}
		}

		ec.addObserver(forEvent: .event1, callback: eventHandler1)
		ec.addObserver(forEvent: .event2, callback: eventHandler2)

		ec.post(event: .event1, object: "val1", userInfo: [42: 43, "42": "43"])

		XCTAssertEqual(globalObject, "val1")
		XCTAssertEqual(globalInfoNumerical, 43)
		XCTAssertEqual(globalInfoString, "43")

		ec.post(event: .event2, object: "val2", userInfo: [42: 44, "42": "44"])

		XCTAssertEqual(globalObject, "val2")
		XCTAssertEqual(globalInfoNumerical, 44)
		XCTAssertEqual(globalInfoString, "44")

		ec.post(event: .event1, object: "val1", userInfo: [42: 43, "42": "43"])

		XCTAssertEqual(globalObject, "val1")
		XCTAssertEqual(globalInfoNumerical, 43)
		XCTAssertEqual(globalInfoString, "43")

		ec.post(event: .event2, object: "val2", userInfo: [42: 44, "42": "44"])

		XCTAssertEqual(globalObject, "val2")
		XCTAssertEqual(globalInfoNumerical, 44)
		XCTAssertEqual(globalInfoString, "44")

	}

}
