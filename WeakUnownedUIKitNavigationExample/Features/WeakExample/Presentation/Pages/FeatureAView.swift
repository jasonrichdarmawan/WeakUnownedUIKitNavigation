//
//  FeatureAView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureAView: ViewControllable {
    let coordinator: Coordinator
    
    let publisher: Publisher
    
    init(
        coordinator: Coordinator = WeakExampleCoordinator(),
        publisher: Publisher = Publisher()
    ) {
        self.coordinator = coordinator
        self.publisher = publisher
    }
    
    var body: some View {
        VStack {
            Text("Feature A")
            
            Button {
                _ = coordinator.pushViewController(WeakExampleRoute.FeatureB)
            } label: {
                Text("Feature B")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
