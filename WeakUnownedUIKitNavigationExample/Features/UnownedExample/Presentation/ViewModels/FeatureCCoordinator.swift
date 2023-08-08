//
//  FeatureCCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import Foundation

class FeatureCCoordinator {
    let id: UUID
    
    var dCoordinator: FeatureDCoordinator?
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}
