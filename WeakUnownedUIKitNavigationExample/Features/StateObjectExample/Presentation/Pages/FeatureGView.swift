//
//  FeatureGView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureGView: ViewControllable {
    let coordinator: Coordinator
    
    init(coordinator: Coordinator = StateObjectExampleCoordinator()) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack {
            Text("Feature G")
            Button {
                _ = coordinator.pushViewController(StateObjectExampleRoute.FeatureH)
            } label: {
                Text("Go to Feature H")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}