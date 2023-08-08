//
//  WeakExampleCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class WeakExampleCoordinator: Coordinator {
    let id: UUID
    
    unowned private let navigationController: UINavigationController
    
    weak private var featureAViewController: UIViewController?
    weak private var publisher: Publisher?
    
    weak private var featureBViewController: UIViewController?
    weak private var subscriber: Subscriber?
    
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
        if let route = route as? WeakExampleRoute {
            return pushToWeakExampleRoute(route)
        }
        return false
    }
    
    func canPopViewController(_ route: NavigationRoute) -> Bool {
        if let route = route as? WeakExampleRoute {
            return canPopToWeakExampleRoute(route)
        }
        return false
    }
    
    func popToViewController(_ route: NavigationRoute) -> Bool {
        if let route = route as? WeakExampleRoute {
            return popToWeakExampleRoute(route)
        }
        return false
    }
    
    func popToRootViewController(animated: Bool) -> Bool {
        navigationController.popToRootViewController(animated: animated)
        return true
    }
    
    private func pushToWeakExampleRoute(_ route: WeakExampleRoute) -> Bool {
        switch route {
        case .FeatureA:
            guard featureAViewController == nil else { return false }
            let publisher = Publisher()
            self.publisher = publisher
            
            let view = FeatureAView(coordinator: self, publisher: publisher)
            let viewController = HostingController(rootView: view)
            self.featureAViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
        case .FeatureB:
            guard featureBViewController == nil else { return false }
            let subscriber = Subscriber()
            self.subscriber = subscriber
            publisher?.subscriber = subscriber
            
            let view = FeatureBView(coordinator: self, subscriber: subscriber)
            let viewController = HostingController(rootView: view)
            self.featureBViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
        }
        
        return true
    }
    
    private func canPopToWeakExampleRoute(_ route: WeakExampleRoute) -> Bool {
        switch route {
        case .FeatureA:
            if featureAViewController == nil { return false }
        case .FeatureB:
            if featureBViewController == nil { return false }
        }
        return true
    }
    
    private func popToWeakExampleRoute(_ route: WeakExampleRoute) -> Bool {
        switch route {
        case .FeatureA:
            guard let featureAViewController else { return false }
            navigationController.popToViewController(featureAViewController, animated: true)
        case .FeatureB:
            guard let featureBViewController else { return false }
            navigationController.popToViewController(featureBViewController, animated: true)
        }
        
        return true
    }
}
