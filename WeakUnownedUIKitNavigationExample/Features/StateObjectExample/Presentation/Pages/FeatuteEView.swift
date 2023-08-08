//
//  FeatuteEView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureEView: ViewControllable {
    let coordinator: Coordinator
    
    // use @ObservedObject instead of @StateObject
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
            Text("Feature E")
            Text("count \(featureEViewModel.count)")
            Button {
                featureEViewModel.count += 1
            } label: {
                Text("increment")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func viewDidAppear(_ viewController: UIViewController) {
        _ = coordinator.pushViewController(StateObjectExampleRoute.FeatureF)
    }
}
