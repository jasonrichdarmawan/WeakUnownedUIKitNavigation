//
//  RootView.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

struct RootView: ViewControllable {
    var coordinator: Coordinator
    
    init(
        coordinator: Coordinator = RootCoordinator()
    ) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        List {
            Button {
                _ = coordinator.showRoute(RootRoute.FeatureA)
            } label: {
                Text("Weak Example")
            }
            Button {
                _ = coordinator.showRoute(RootRoute.FeatureC)
            } label: {
                Text("Unowned Example")
            }
            Button {
                _ = coordinator.showRoute(RootRoute.FeatureE)
            } label: {
                Text("State Object Example")
            }
            Button {
                _ = coordinator.showRoute(RootRoute.FeatureI)
            } label: {
                Text("UIKit View Example")
            }
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
