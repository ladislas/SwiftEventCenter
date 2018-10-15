//
//  main.swift
//  ExternalEventCenter
//
//  Created by Ladislas de Toldi on 12/10/2018.
//

import Foundation
import EventCenter

let delay: UInt32 = 0 // you can change this to 1 to better see the execution flow

struct DriverEvent {
	
	static let turnKey = Event.Name("turnKey")
	static let pressAccelerationPedal = Event.Name("pressAccelerationPedal")

}

struct CarEvent {

	static let turnsOn = Event.Name("carTurnsOn")
	static let makesNoize = Event.Name("carMakesNoize")

}

class Car {

	let ec: EventCenter?
	let name: String

	init(name: String, ec: EventCenter? = nil) {
		self.name = name
		print("Creating \(name) car...")
		self.ec = ec
		ec?.addObserver(forEvent: DriverEvent.turnKey, callback: self.turnEngineOn)
		ec?.addObserver(forEvent: DriverEvent.pressAccelerationPedal, callback: self.goesFaster)
		sleep(delay)
		print("\(name) created!\n")

	}

	func turnEngineOn(event: Event) {
		print("... *\(name) makes no sound* ...\n")
		ec?.post(event: CarEvent.turnsOn, userInfo: ["intensity": "super", "volume": "quiet"])
	}

	func goesFaster(event: Event) {
		print("Vroooouuuummmm!\n")
		ec?.post(event: CarEvent.makesNoize, userInfo: ["intensity": "super", "volume": "LOUD"])
	}

}

class Driver {

	let ec: EventCenter?
	let name: String

	init(name: String? = nil, ec: EventCenter? = nil) {
		self.name = name ?? "Unnamed driver"
		print("Preapring \(self.name)...")
		self.ec = ec
		ec?.addObserver(forEvent: CarEvent.turnsOn, callback: self.noiseReaction)
		ec?.addObserver(forEvent: CarEvent.makesNoize, callback: self.noiseReaction)
		sleep(delay)
		print("\(self.name) ready!\n")
	}

	func turnKey() {
		print("\(name) turning key in ignition\n")
		ec?.post(event: DriverEvent.turnKey)
	}

	func accelerate() {
		print("\(name) pushing on the accelerate pedal\n")
		ec?.post(event: DriverEvent.pressAccelerationPedal)
	}

	func noiseReaction(event: Event) {

		if let info = event.userInfo {

			let intensity = info["intensity"] as! String
			let volume = info["volume"] as! String

			if volume == "LOUD" {
				print("Woaw! It's \(intensity) \(volume)!\n")
			}
			if volume == "quiet" {
				print("This car is \(intensity) \(volume)...\n")
			}

		}

	}

}

print()

let ec = EventCenter()

let car = Car(name: "Ferrari", ec: ec)

// here not event manager is passed to John
// the car events won't be posted:
let driver1 = Driver()
sleep(delay)
driver1.turnKey()
sleep(delay)
driver1.accelerate()

sleep(delay)

// here we pass the event manager to nick
// the car events will be posted:
let driver2 = Driver(name: "Nick", ec: ec)
sleep(delay)
driver2.turnKey()
sleep(delay)
driver2.accelerate()
