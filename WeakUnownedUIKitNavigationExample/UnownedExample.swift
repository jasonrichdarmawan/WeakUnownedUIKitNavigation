//
//  UnownedExample.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

final class UnownedExampleCoordinator {
    let id: UUID
    
    unowned let navigationController: UINavigationController
    unowned var cCoordinator: FeatureCCoordinator?
    
    init(
        id: UUID = UUID(),
        navigationController: UINavigationController = NavigationController()
    ) {
        self.id = id
        self.navigationController = navigationController
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func enter() -> Bool {
        let cCoordinator = FeatureCCoordinator()
        
        self.cCoordinator = cCoordinator
        
        let view = FeatureCView(coordinator: self, cCoordinator: cCoordinator)
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
    
    func next() -> Bool {
        guard let cCoordinator else { return false }
        
        let dCoordinator = FeatureDCoordinator(cCoordinator: cCoordinator)
        
        let view = FeatureDView(coordinator: self, dCoordinator: dCoordinator)
    
        cCoordinator.dCoordinator = dCoordinator
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
}

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
    
    let coordinator: UnownedExampleCoordinator
    
    let dCoordinator: FeatureDCoordinator
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: UnownedExampleCoordinator = UnownedExampleCoordinator(),
        dCoordinator: FeatureDCoordinator = FeatureDCoordinator()
    ) {
        self.holder = holder
        self.coordinator = coordinator
        self.dCoordinator = dCoordinator
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
    
    let coordinator: UnownedExampleCoordinator
    
    let cCoordinator: FeatureCCoordinator
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: UnownedExampleCoordinator = UnownedExampleCoordinator(),
        cCoordinator: FeatureCCoordinator = FeatureCCoordinator()
    ) {
        self.holder = holder
        self.coordinator = coordinator
        self.cCoordinator = cCoordinator
    }
    
    var body: some View {
        VStack {
            Text("Feature C")
            
            Button {
                _ = coordinator.next()
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
