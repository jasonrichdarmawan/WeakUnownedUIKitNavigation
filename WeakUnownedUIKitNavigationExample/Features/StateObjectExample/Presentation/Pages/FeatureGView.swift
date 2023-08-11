//
//  FeatureGView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureGView: ViewControllable {
    @ObservedObject var featureGViewModel: FeatureGViewModel
    
    init(featureGViewModel: FeatureGViewModel) {
        self.featureGViewModel = featureGViewModel
    }
    
    var body: some View {
        VStack {
            Text("Feature G")
            Button {
                _ = featureGViewModel.showRoute()
            } label: {
                Text("Go to Feature H")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
