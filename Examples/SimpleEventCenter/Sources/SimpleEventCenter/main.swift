//
//  main.swift
//  SimpleEventListener
//
//  Created by Ladislas de Toldi on 12/10/2018.
//  Adapted from from: https://github.com/StephenHaney/Swift-Custom-Events
//

import Foundation
import EventCenter

class Cat {

    let ec = EventCenter()
    
    func meow() {
        print("Cat: MRaawwweeee")
        self.ec.post(event: Event.Name("meow"), object: "The cat is hungry")
    }

}

class Human {

    func adopt(cat: Cat) {

        cat.ec.addObserver(forEvent: Event.Name("meow"), callback: { _ in
            print("Human: Awww, what a cute kitty *pets cat*")
        })

        cat.ec.addObserver(forEvent: Event.Name("meow"), callback: self.dayDream)

        cat.ec.addObserver(forEvent: Event.Name("meow"), callback: self.ponderCat)
    }
    
	func dayDream(event: Event) {
        print("Human daydreams about owning a dog")
    }
    
	func ponderCat(event: Event) {
        if let info = event.object as? String {
            print("Oooh, I think I know:")
            print(info)
        }
    }

}

let zeus = Cat()
let stephen = Human()

stephen.adopt(cat: zeus)
zeus.meow()
