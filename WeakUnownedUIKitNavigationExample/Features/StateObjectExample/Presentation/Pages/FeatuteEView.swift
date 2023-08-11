//
//  FeatuteEView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

struct FeatureEView: ViewControllable {
    // use @ObservedObject instead of @StateObject
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(
        featureEViewModel: FeatureEViewModel
    ) {
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
}
