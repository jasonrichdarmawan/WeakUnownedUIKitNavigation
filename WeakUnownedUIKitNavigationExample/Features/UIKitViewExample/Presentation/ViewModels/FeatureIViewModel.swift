//
//  FeatureIViewModel.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 16/08/23.
//

import Foundation

final class FeatureIViewModel: ObservableObject {
    private var coordinator: Coordinator
    
    @Published var count: Int
    
    init(coordinator: Coordinator, count: Int = 1) {
        self.coordinator = coordinator
        self.count = count
    }
}
