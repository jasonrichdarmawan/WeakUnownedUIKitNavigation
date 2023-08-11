//
//  FeatureGViewModel.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 11/08/23.
//

import Foundation

final class FeatureGViewModel: ObservableObject {
    private let id: UUID
    private var coordinator: Coordinator
    
    init(id: UUID = UUID(), coordinator: Coordinator) {
        self.id = id
        self.coordinator = coordinator
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func showRoute() -> Bool {
        return coordinator.showRoute(StateObjectExampleRoute.FeatureH)
    }
}
