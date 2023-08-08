//
//  FeatureCView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureCView: ViewControllable {
    let coordinator: Coordinator
    
    let cCoordinator: FeatureCCoordinator
    
    init(
        coordinator: UnownedExampleCoordinator = UnownedExampleCoordinator(),
        cCoordinator: FeatureCCoordinator = FeatureCCoordinator()
    ) {
        self.coordinator = coordinator
        self.cCoordinator = cCoordinator
    }
    
    var body: some View {
        VStack {
            Text("Feature C")
            
            Button {
                _ = coordinator.showRoute(UnownedExampleRoute.FeatureD)
            } label: {
                Text("Feature D")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
