//
//  FeatureDCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

class FeatureDCoordinator {
    let id: UUID
    
    // try to remove unowned
    // then navigate: Feature C -> Feature D -> go back to root view
    // cCoordinator and dCoordinator will not deinit
    unowned let cCoordinator: FeatureCCoordinator
    
    init(id: UUID = UUID(), cCoordinator: FeatureCCoordinator = FeatureCCoordinator()) {
        self.id = id
        self.cCoordinator = cCoordinator
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}
