//
//  FeatureHView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureHView: ViewControllable {
    let coordinator: Coordinator
    
    init(coordinator: Coordinator = StateObjectExampleCoordinator()) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack {
            Text("Feature H")
            Button {
                _ = coordinator.popToRootViewController(animated: true)
            } label: {
                Text("pop to root")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
