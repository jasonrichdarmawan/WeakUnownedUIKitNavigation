//
//  FeatureFView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureFView: ViewControllable {
    let coordinator: Coordinator
    
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(
        coordinator: Coordinator = StateObjectExampleCoordinator(),
        featureEViewModel: FeatureEViewModel = FeatureEViewModel()
    ) {
        self.coordinator = coordinator
        self.featureEViewModel = featureEViewModel
    }
    
    var body: some View {
        VStack {
            Text("Feature F")
            Text("count \(featureEViewModel.count)")
            Button {
                featureEViewModel.count += 1
            } label: {
                Text("increment")
            }
            .buttonStyle(.borderedProminent)
            Button {
                _ = coordinator.pushViewController(StateObjectExampleRoute.FeatureG)
            } label: {
                Text("Feature G")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
