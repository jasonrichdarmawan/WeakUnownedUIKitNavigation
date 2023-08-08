//
//  FeatureDView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureDView: ViewControllable {
    let coordinator: Coordinator
    
    let dCoordinator: FeatureDCoordinator
    
    init(
        coordinator: Coordinator = UnownedExampleCoordinator(),
        dCoordinator: FeatureDCoordinator = FeatureDCoordinator()
    ) {
        self.coordinator = coordinator
        self.dCoordinator = dCoordinator
    }
    
    var body: some View {
        Text("Feature D")
    }
}
