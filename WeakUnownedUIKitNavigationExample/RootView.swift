//
//  RootView.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

final class RootCoordinator {
    let id: UUID
    
    unowned let navigationController: NavigationController
    unowned var weakCoordinator: WeakExampleCoordinator?
    unowned var unownedCoordinator: UnownedExampleCoordinator?
    unowned var stateObjectCoordinator: StateObjectExampleCoordinator?
    
    init(
        id: UUID = UUID(),
        navigationController: NavigationController = NavigationController()
    ) {
        self.id = UUID()
        self.navigationController = navigationController
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func enter() -> Bool {
        let view = RootView(coordinator: self)
        
        navigationController.pushViewController(view.viewController, animated: false)
        
        return true
    }
    
    func enterWeakCoordinator() -> Bool {
        let coordinator = WeakExampleCoordinator(navigationController: navigationController)
        
        weakCoordinator = coordinator
        
        guard let weakCoordinator else { return false }
        
        return weakCoordinator.enter()
    }
    
    func enterUnownedCoordinator() -> Bool {
        let coordinator = UnownedExampleCoordinator(navigationController: navigationController)
        
        unownedCoordinator = coordinator
        
        guard let unownedCoordinator else { return false }
        
        return unownedCoordinator.enter()
    }
    
    func enterStateObjectCoordinator() -> Bool {
        let coordinator = StateObjectExampleCoordinator(navigationController: navigationController)
        
        stateObjectCoordinator = coordinator
        
        guard let stateObjectCoordinator else { return false }
        
        return stateObjectCoordinator.enter()
    }
}

struct RootView: ViewControllable {
    var holder: NavStackHolder
    
    var coordinator: RootCoordinator
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: RootCoordinator = RootCoordinator()
    ) {
        self.holder = holder
        self.coordinator = coordinator
    }
    
    var body: some View {
        List {
            Button {
                _ = coordinator.enterWeakCoordinator()
            } label: {
                Text("Weak Example")
            }
            Button {
                _ = coordinator.enterUnownedCoordinator()
            } label: {
                Text("Unowned Example")
            }
            Button {
                _ = coordinator.enterStateObjectCoordinator()
            } label: {
                Text("State Object Example")
            }
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
