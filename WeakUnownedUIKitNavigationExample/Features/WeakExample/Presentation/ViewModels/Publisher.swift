//
//  Publisher.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import Foundation

class Publisher {
    let id: UUID
    
    // try to remove weak.
    // then navigate: Feature A -> Feature B -> go back.
    // subscriber object will not deinit
    weak var subscriber: Subscriber?
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}
