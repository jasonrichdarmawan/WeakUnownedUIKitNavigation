//
//  FeatureHView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureHView: ViewControllable {
    @ObservedObject var featureHViewModel: FeatureHViewModel
    
    init(featureHViewModel: FeatureHViewModel) {
        self.featureHViewModel = featureHViewModel
    }
    
    var body: some View {
        VStack {
            Text("Feature H")
            Button {
                _ = featureHViewModel.popToRootViewController(animated: true)
            } label: {
                Text("pop to root")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
