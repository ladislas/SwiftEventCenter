# Swift Event Center

[![swift-version](https://img.shields.io/badge/Swift-4.2-orange.svg?style=flat)](swift.org)
[![spm](https://img.shields.io/badge/spm-v1.1.1-blue.svg)](https://github.com/apple/swift-package-manager)
[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftEventCenter.svg)](https://cocoapods.org/pods/SwiftEventCenter)
[![Build Status](https://travis-ci.org/ladislas/SwiftEventCenter.svg)](https://travis-ci.org/ladislas/SwiftEventCenter)
[![SonarCloud](https://sonarcloud.io/api/project_badges/measure?project=ladislas_SwiftEventCenter&metric=alert_status)](https://sonarcloud.io/dashboard?id=ladislas_SwiftEventCenter)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=ladislas_SwiftEventCenter&metric=coverage)](https://sonarcloud.io/dashboard?id=ladislas_SwiftEventCenter)
[![SwiftEventCenter](https://img.shields.io/badge/license-Apache--2.0-lightgrey.svg)](https://github.com/ladislas/SwiftEventCenter/blob/master/LICENSE)

## About

Swift Event Center to create custom events and respond to them.

The idea was to build a simple event center from scratch to:

- better understand how a notification/event center would work
- have simple event manager for simple tasks
- in pure Swift
- and not use Apple's Notification Center

The interesting thing about the process is that while building it, I got a deeper understanding of how Notification Center.

To make it easier for new comers, I decided to keep Apple's way of naming things.

**Note:** EventCenter is not meant to be a full replacement of Notification Center. It is a simpler alternative (as in "*simpler to use, but also simpler in terms of functionalities*") that should be good enough for *simple projects*.

### Features

EventCenter allows you to:

- [x] - add observer for `Event.Name` (a.k.a. `Notification.Name`)
- [x] - specify a name for added observers so that they can be removed independently
- [x] - remove all observers for a specific `Event.Name`
- [x] - remove one observer with a specific `name` for a specific `Event.Name`
- [x] - post events and pass `object:Any?` & `userInfo:[AnyHashable:Any]?` 
- [ ] - specify priority for each observer (**not implemented yet**)


## Installation

With SPM, add the following to the dependencies of your `Package.swift`

```swift
.package(url: "https://github.com/ladislas/SwiftEventCenter", from: "1.1.1")
```


## Usage

`Event` is just a `typealias` for `Notification`.

See [docs](./docs), [Examples](./Examples) & [Tests](./Tests) for more information.

```swift
import EventCenter

let ec = EventCenter()

...

ec.addObserver(forEvent: Event.Name("event1"), name: "obs1", callback: { event: Event in 

	if let obj = event.object {
		print("Hello, \(obj)!")	
	}

})

...

ec.post(event: Event.Name("event1"), object: "World")
```

## Authors

Made with ❤️ by:

- **Ladislas de Toldi** - [ladislas](https://github.com/ladislas)

## License

Apache 2.0 @ Ladislas de Toldi

**Original Work**

*This project is based on great people's ideas. The original idea was created by [Stephen Haney](https://github.com/StephenHaney/Swift-Custom-Events). It was then improved by [Robin Walter](https://github.com/robinwalterfit)'s [Swift-Events](https://github.com/robinwalterfit/Swift-Events). First I wanted to fork Robin's repo but after spending a couple of hours on it, I decided to rewrite most of it. Original work from [Stephen Haney](https://github.com/StephenHaney) & [Robin Walter](https://github.com/robinwalterfit) is under MIT.*
