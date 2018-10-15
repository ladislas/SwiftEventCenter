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

		let myAction = ObserverStructure(priority: ObserverPriority.normal, callback: myFunction)

		XCTAssertEqual(myAction.priority, ObserverPriority.normal)
		XCTAssertNotNil(myAction.callback)

	}

	func test_equality_sameFunction_sameName() {

		func myFunction(event: Event) {}

		let myAction1 = ObserverStructure(name: "myFunction", priority: ObserverPriority.normal, callback: myFunction)
		let myAction2 = ObserverStructure(name: "myFunction", priority: ObserverPriority.normal, callback: myFunction)

		XCTAssertEqual(myAction1, myAction2)

	}

	func test_equality_differentFunction_sameName() {

		func myFunction1(event: Event) {}
		func myFunction2(event: Event) {}

		let myAction1 = ObserverStructure(name: "myFunction", priority: ObserverPriority.normal, callback: myFunction1)
		let myAction2 = ObserverStructure(name: "myFunction", priority: ObserverPriority.normal, callback: myFunction2)

		XCTAssertEqual(myAction1, myAction2)

	}

	func test_equality_sameFunction_differentName() {

		func myFunction1(event: Event) {}

		let myAction1 = ObserverStructure(name: "myFunction1", priority: ObserverPriority.normal, callback: myFunction1)
		let myAction2 = ObserverStructure(name: "myFunction2", priority: ObserverPriority.normal, callback: myFunction1)

		XCTAssertNotEqual(myAction1, myAction2)

	}

	func test_equality_differentFunction_differentName() {

		func myFunction1(event: Event) {}
		func myFunction2(event: Event) {}

		let myAction1 = ObserverStructure(name: "myFunction1", priority: ObserverPriority.normal, callback: myFunction1)
		let myAction2 = ObserverStructure(name: "myFunction2", priority: ObserverPriority.normal, callback: myFunction2)

		XCTAssertNotEqual(myAction1, myAction2)

	}

}
