//
//  UnownedExampleCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class UnownedExampleCoordinator: Coordinator {
    let id: UUID
    
    unowned private let navigationController: UINavigationController
    
    weak private var featureCViewController: UIViewController?
    weak private var cCoordinator: FeatureCCoordinator?
    
    weak private var featureDViewController: UIViewController?
    weak private var dCoordinator: FeatureDCoordinator?
    
    init(
        id: UUID = UUID(),
        navigationController: UINavigationController = NavigationController()
    ) {
        self.id = id
        self.navigationController = navigationController
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func pushViewController(_ route: NavigationRoute) -> Bool {
        if let route = route as? UnownedExampleRoute {
            return pushToUnownedExampleRoute(route)
        }
        return false
    }
    
    func canPopViewController(_ route: NavigationRoute) -> Bool {
        if let route = route as? UnownedExampleRoute {
            return canPopToUnownedExampleRoute(route)
        }
        return false
    }
    
    func popToViewController(_ route: NavigationRoute) -> Bool {
        if let route = route as? UnownedExampleRoute {
            return popToUnownedExampleRoute(route)
        }
        return false
    }
    
    func popToRootViewController(animated: Bool) -> Bool {
        navigationController.popToRootViewController(animated: animated)
        
        return true
    }
    
    private func pushToUnownedExampleRoute(_ route: UnownedExampleRoute) -> Bool {
        switch route {
        case .FeatureC:
            guard featureCViewController == nil else { return false }
            
            let cCoordinator = FeatureCCoordinator()
            self.cCoordinator = cCoordinator
            
            let view = FeatureCView(coordinator: self, cCoordinator: cCoordinator)
            let viewController = HostingController(rootView: view)
            self.featureCViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
        case .FeatureD:
            guard featureDViewController == nil else { return false }
            
            guard let cCoordinator else { return false }
            
            let dCoordinator = FeatureDCoordinator(cCoordinator: cCoordinator)
            self.dCoordinator = dCoordinator
            
            let view = FeatureDView(coordinator: self, dCoordinator: dCoordinator)
            let viewController = HostingController(rootView: view)
            self.featureDViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
        }
        
        return true
    }
    
    func canPopToUnownedExampleRoute(_ route: UnownedExampleRoute) -> Bool {
        switch route {
        case .FeatureC:
            if featureCViewController == nil { return false }
        case .FeatureD:
            if featureDViewController == nil { return false }
        }
        
        return true
    }
    
    func popToUnownedExampleRoute(_ route: UnownedExampleRoute) -> Bool {
        switch route {
        case .FeatureC:
            guard let featureCViewController else { return false }
            navigationController.popToViewController(featureCViewController, animated: true)
        case .FeatureD:
            guard let featureDViewController else { return false }
            navigationController.popToViewController(featureDViewController, animated: true)
        }
        
        return true
    }
}
