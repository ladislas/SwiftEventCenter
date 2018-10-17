//
//  EventCenter.swift
//  SwiftEventCenter
//
//  Created by Ladislas de Toldi on 14/10/2018.
//

import Foundation

/**
EventCenter class to add & remove observers for specific events.

## Usage Example:

```swift
import EventCenter
```
*/
public class EventCenter {

	//
	// MARK: - Properties
	//

	/**
	Dictionnary containing the oberservers for each event
	*/
	var observers: [Event.Name: [ObserverStructure]]

	//
	// MARK: - Intialization
	//

	/**
	Initialize Event Center.

	## Usage Example:

	```swift
	let ec = EventCenter()
	```
	*/
	public init() {

		observers = [Event.Name: [ObserverStructure]]()

	}

	//
	// MARK: - Add observers
	//

	/**
	Add observer with optional name for specific event.

	## Usage Example:

	```swift
	ec.addObserver(forEvent: Event.Name("event1"), name: "obs1", callback: { event: Event in
		if let obj = event.object {
			print("Hello, \(obj)!")
		}
	})
	```

	- Warning: `priority` is not yet implemented

	- Parameter event: `Event.Name` (a.k.a. `Notification.Name`) the observer must be registered to
	- Parameter id: Optional id for the oberserver, can be used to remove the observer later
	- Parameter priority: the priority of the observer
	- Parameter callback: the function you want to perform when the event is posted
	*/
	public func addObserver(forEvent event: Event.Name, withId id: String? = nil, priority: UInt8 = ObserverPriority.normal, callback: @escaping ObserverCallback) {

		let os = ObserverStructure(id: id, priority: priority, callback: callback)

		if let _ = self.observers[event] {
			observers[event]?.append(os)
		}
		else {
			self.observers[event] = [os]
		}

	}

	//
	// MARK: - Remove observers
	//

	/**
	Remove all observers of specific event.

	## Usage Example:

	```swift
	ec.removeObservers(forEvent: Event.Name("event1"))
	```

	- Parameter event: event name
	*/
	public func removeObservers(forEvent event: Event.Name) {

		self.observers.removeValue(forKey: event)

	}

	/**
	Remove all observers of specific event.

	## Usage Example:

	```swift
	ec.removeObserver(name: "obs1", forEvent: Event.Name("event1"))
	```

	- Parameter id: id of the observer(s) to be removed
	- Parameter event: event name
	*/
	public func removeObserver(withId id: String?, forEvent event: Event.Name) {

		if let observers = self.observers[event] {

			if observers.count == 1 {
				self.removeObservers(forEvent: event)
				return
			}

			self.observers[event]?.removeAll(where: {$0.id == id})

		}

	}

	/**
	Remove all the observers from the Event Center.

	## Usage Example:

	```swift
	ec.removeAllObservers()
	```
	*/
	public func removeAllObservers() {

		self.observers = [Notification.Name: [ObserverStructure]]()

	}

	//
	// MARK: - Post events
	//

	/**
	Post an event with an optional `object` & `userInfo`

	## Usage Example:

	```swift
	ec.post(event: Event.Name("event1"), object: "World", userInfo: [42: "String", "Number": 42])
	```

	- Parameter event: name of the event
	- Parameter object: single object you want to pass to the observer
	- Parameter userInfo: dictionnary you want to pass to the observer
	*/
	public func post(event: Event.Name, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {

		if let observers = self.observers[event] {

			let event = Event(name: event, object: object, userInfo: userInfo)

			observers.forEach { observer in
				observer.callback(event)
			}

		}

	}

}
