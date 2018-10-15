//
//  EventPriority.swift
//  SwiftEventCenter
//
//  Created by Ladislas de Toldi on 14/10/2018.
//

import Foundation

/**
This class provides standardized observer priority.

It is easy to extended this class to add your own priorities

## Example Usage

```swift
extension ObserverPriority {
	public static let myPriority: UInt8 = 42
}
```

- Note: ObserverPriority must be of type `UInt8`
*/

public class ObserverPriority {

	public static let lowest: UInt8 = 0
	public static let low: UInt8 = 64
	public static let normal: UInt8 = 128
	public static let high: UInt8 = 192
	public static let highest: UInt8 = 255

}
