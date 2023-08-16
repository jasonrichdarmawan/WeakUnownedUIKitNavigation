//
//  FeatureIView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 16/08/23.
//

import SwiftUI

struct FeatureIView: ViewControllable {
    @ObservedObject var featureIVM: FeatureIViewModel
    
    init(featureIVM: FeatureIViewModel) {
        self.featureIVM = featureIVM
    }
    
    var body: some View {
        VStack {
            Text("Feature I")
            Text("count \(featureIVM.count)")
            Button {
                featureIVM.count += 1
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
