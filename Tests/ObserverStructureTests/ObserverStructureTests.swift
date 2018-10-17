//
//  EventActionTests.swift
//  SwiftEventManager
//
//  Created by Ladislas de Toldi on 14/10/2018.
//

import Foundation
import XCTest

@testable import EventCenter

final class EventActionTests: XCTestCase {

	func test_init() {

		func myFunction(event: Event) {}

		let myObserver = ObserverStructure(priority: ObserverPriority.normal, callback: myFunction)

		XCTAssertEqual(myObserver.priority, ObserverPriority.normal)
		XCTAssertNotNil(myObserver.callback)

	}

	func test_equality_sameFunction_sameName() {

		func myFunction(event: Event) {}

		let myObserver1 = ObserverStructure(id: "obsId", priority: ObserverPriority.normal, callback: myFunction)
		let myObserver2 = ObserverStructure(id: "obsId", priority: ObserverPriority.normal, callback: myFunction)

		XCTAssertEqual(myObserver1, myObserver2)

	}

	func test_equality_differentFunction_sameName() {

		func myFunction1(event: Event) {}
		func myFunction2(event: Event) {}

		let myObserver1 = ObserverStructure(id: "obsId", priority: ObserverPriority.normal, callback: myFunction1)
		let myObserver2 = ObserverStructure(id: "obsId", priority: ObserverPriority.normal, callback: myFunction2)

		XCTAssertEqual(myObserver1, myObserver2)

	}

	func test_equality_sameFunction_differentName() {

		func myFunction1(event: Event) {}

		let myObserver1 = ObserverStructure(id: "obsId1", priority: ObserverPriority.normal, callback: myFunction1)
		let myObserver2 = ObserverStructure(id: "obsId2", priority: ObserverPriority.normal, callback: myFunction1)

		XCTAssertNotEqual(myObserver1, myObserver2)

	}

	func test_equality_differentFunction_differentName() {

		func myFunction1(event: Event) {}
		func myFunction2(event: Event) {}

		let myObserver1 = ObserverStructure(id: "obsId1", priority: ObserverPriority.normal, callback: myFunction1)
		let myObserver2 = ObserverStructure(id: "obsId2", priority: ObserverPriority.normal, callback: myFunction2)

		XCTAssertNotEqual(myObserver1, myObserver2)

	}

}
