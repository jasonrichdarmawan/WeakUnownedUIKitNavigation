//
//  FeatureBView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureBView: ViewControllable {
    let coordinator: Coordinator
    
    let subscriber: Subscriber
    
    init(
        coordinator: Coordinator = WeakExampleCoordinator(),
        subscriber: Subscriber = Subscriber()
    ) {
        self.coordinator = coordinator
        self.subscriber = subscriber
    }
    
    var body: some View {
        VStack {
            Text("Feature B")
            Button {
                _ = coordinator.popToRootViewController(animated: true)
            } label: {
                Text("Pop to root")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
