//
//  FeatureEViewModel.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class FeatureEViewModel: ObservableObject {
    private let id: UUID
    
    private var coordinator: Coordinator
    
    @Published var count: Int
    
    init(id: UUID = UUID(), coordinator: Coordinator, count: Int = 0) {
        self.id = id
        self.coordinator = coordinator
        self.count = count
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func showRoute() -> Bool {
        return coordinator.showRoute(StateObjectExampleRoute.FeatureG)
    }
}
