//
//  EventStructure.swift
//  SwiftEventCenter
//
//  Created by Ladislas de Toldi on 14/10/2018.
//

import Foundation

/**
Typealias for event callback

*/
public typealias ObserverCallback = ((Event) -> Void)

/**
ObserverStructure class to encapsulate an observer

## Usage Example:

```swift
import EventCenter
```
*/
class ObserverStructure {

	//
	// MARK: - Properties
	//

	/**
	The name of the observer
	*/
	let id: String?

	/**
	Callback of the observer
	*/
	let callback: ObserverCallback

	/**
	Priority of the observer

	- Warning: Not implemented yet
	*/
	let priority: UInt8

	//
	// MARK: - Initializer
	//

	/**
	Initialize an observer struct

	- Parameter name: name of the observer
	- Parameter priority: priority of the observer
	- Parameter callback: callback to be called when event is posted
	*/
	init(id: String? = nil, priority: UInt8, callback: @escaping ObserverCallback) {

		self.id = id
		self.priority = priority
		self.callback = callback

	}

}

extension ObserverStructure: Equatable {

	/**
	Compare observers' names and return equality

	- Parameter lhs: observer structure
	- Parameter rhs: observer strucutre
	- Returns: true if names are the same
	*/
	static func == (lhs: ObserverStructure, rhs: ObserverStructure) -> Bool {
		return
			lhs.id == rhs.id
	}

}
