//
//  FeatureFView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureFView: ViewControllable {
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(featureEViewModel: FeatureEViewModel) {
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
                _ = featureEViewModel.showRoute()
            } label: {
                Text("Feature G")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
