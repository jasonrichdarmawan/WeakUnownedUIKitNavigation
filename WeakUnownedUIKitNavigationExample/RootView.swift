//
//  RootView.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

struct RootView: ViewControllable {
    var holder: NavStackHolder
    
    init(holder: NavStackHolder = NavStackHolder()) {
        self.holder = holder
    }
    
    var body: some View {
        List {
            Button {
                _ = navigateToFeatureA()
            } label: {
                Text("Weak Example")
            }
            Button {
                _ = navigateToFeatureC()
            } label: {
                Text("Unowned Example")
            }
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func navigateToFeatureA() -> Bool {
        guard let navigationController = holder.viewController?.navigationController else { return false }
        
        let view = FeatureAView()
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
    
    func navigateToFeatureC() -> Bool {
        guard let navigationController = holder.viewController?.navigationController else { return false }
        
        let view = FeatureCView()
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
}
