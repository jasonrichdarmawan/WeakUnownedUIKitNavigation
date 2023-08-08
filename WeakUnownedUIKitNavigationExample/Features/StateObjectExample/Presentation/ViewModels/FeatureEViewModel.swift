//
//  FeatureEViewModel.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class FeatureEViewModel: ObservableObject {
    let id: UUID
    
    @Published var count: Int
    
    init(id: UUID = UUID(), count: Int = 0) {
        self.id = id
        self.count = count
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}
