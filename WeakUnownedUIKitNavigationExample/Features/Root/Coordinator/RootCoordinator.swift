//
//  RootCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class RootCoordinator: Coordinator {
    let id: UUID
    
    unowned private let navigationController: UINavigationController
    
    weak private var rootViewController: UIViewController?
    weak private var weakCoordinator: WeakExampleCoordinator?
    weak private var unownedCoordinator: UnownedExampleCoordinator?
    weak private var stateObjectCoordinator: StateObjectExampleCoordinator?
    weak private var uiKitViewExampleCoordinator: UIKitViewExampleCoordinator?
    
    init(
        id: UUID = UUID(),
        navigationController: UINavigationController = NavigationController()
    ) {
        self.id = UUID()
        self.navigationController = navigationController
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func showRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? RootRoute {
            return pushToRootRoute(route)
        }
        return false
    }
    
    func canPopToRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? RootRoute {
            return canPopToRootRoute(route)
        }
        return false
    }
    
    func popToRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? RootRoute {
            return popToRootRoute(route)
        }
        return false
    }
    
    func popToRootViewController(animated: Bool) -> Bool {
        navigationController.popToRootViewController(animated: animated)
        
        return true
    }
    
    private func pushToRootRoute(_ route: RootRoute) -> Bool {
        switch route {
        case .Root:
            guard rootViewController == nil else { return false }
            
            let view = RootView(coordinator: self)
            let viewController = HostingController(rootView: view)
            
            rootViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
            return true
        case .FeatureA:
            guard weakCoordinator == nil else { return false }
            
            let coordinator = WeakExampleCoordinator(navigationController: navigationController)
            weakCoordinator = coordinator
            
            return coordinator.showRoute(WeakExampleRoute.FeatureA)
        case .FeatureC:
            guard unownedCoordinator == nil else { return false }
            
            let coordinator = UnownedExampleCoordinator(navigationController: navigationController)
            unownedCoordinator = coordinator
            
            return coordinator.showRoute(UnownedExampleRoute.FeatureC)
        case .FeatureE:
            guard stateObjectCoordinator == nil else { return false }
            
            let coordinator = StateObjectExampleCoordinator(navigationController: navigationController)
            stateObjectCoordinator = coordinator
            
            return coordinator.showRoute(StateObjectExampleRoute.FeatureE)
        case .FeatureI:
            guard uiKitViewExampleCoordinator == nil else { return false }
            
            let coordinator = UIKitViewExampleCoordinator(navigationController: navigationController)
            uiKitViewExampleCoordinator = coordinator
            
            return coordinator.showRoute(UIKitViewExampleRoute.FeatureI)
        }
    }
    
    private func canPopToRootRoute(_ route: RootRoute) -> Bool {
        switch route {
        case .Root:
            if rootViewController == nil { return false }
        case .FeatureA:
            if weakCoordinator == nil { return false }
        case .FeatureC:
            if unownedCoordinator == nil { return false }
        case .FeatureE:
            if stateObjectCoordinator == nil { return false }
        case .FeatureI:
            if uiKitViewExampleCoordinator == nil { return false }
        }
        
        return true
    }
    
    private func popToRootRoute(_ route: RootRoute) -> Bool {
        switch route {
        case .Root:
            guard let rootViewController else { return false }
            navigationController.popToViewController(rootViewController, animated: true)
            return true
        case .FeatureA:
            guard let weakCoordinator else { return false }
            return weakCoordinator.popToRoute(WeakExampleRoute.FeatureA)
        case .FeatureC:
            guard let unownedCoordinator else { return false }
            return unownedCoordinator.popToRoute(UnownedExampleRoute.FeatureC)
        case .FeatureE:
            guard let stateObjectCoordinator else { return false }
            return stateObjectCoordinator.popToRoute(StateObjectExampleRoute.FeatureE)
        case .FeatureI:
            guard let uiKitViewExampleCoordinator else { return false }
            return uiKitViewExampleCoordinator.popToRoute(UIKitViewExampleRoute.FeatureI)
        }
    }
}
