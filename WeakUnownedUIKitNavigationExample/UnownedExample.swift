//
//  UnownedExample.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

class FeatureDCoordinator {
    let id: UUID
    
    // try to remove unowned
    // then navigate: Feature C -> Feature D -> go back to root view
    // cCoordinator and dCoordinator will not deinit
    unowned let cCoordinator: FeatureCCoordinator
    
    init(id: UUID = UUID(), cCoordinator: FeatureCCoordinator = FeatureCCoordinator()) {
        self.id = id
        self.cCoordinator = cCoordinator
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

struct FeatureDView: ViewControllable {
    var holder: NavStackHolder
    
    let coordinator: FeatureDCoordinator
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: FeatureDCoordinator = FeatureDCoordinator()
    ) {
        self.holder = holder
        self.coordinator = coordinator
    }
    
    var body: some View {
        Text("Feature D")
    }
}

class FeatureCCoordinator {
    let id: UUID
    
    var dCoordinator: FeatureDCoordinator?
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

struct FeatureCView: ViewControllable {
    var holder: NavStackHolder
    
    let coordinator: FeatureCCoordinator
    
    init(holder: NavStackHolder = NavStackHolder(), coordinator: FeatureCCoordinator = FeatureCCoordinator()) {
        self.holder = holder
        self.coordinator = coordinator
    }
    
    var body: some View {
        VStack {
            Text("Feature C")
            
            Button {
                _ = navigateToFeatureD()
            } label: {
                Text("Feature D")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func navigateToFeatureD() -> Bool {
        guard let navigationController = holder.viewController?.navigationController else { return false }
        
        let dCoordinator = FeatureDCoordinator(cCoordinator: coordinator)
        coordinator.dCoordinator = dCoordinator
        
        let view = FeatureDView(coordinator: dCoordinator)
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
}
