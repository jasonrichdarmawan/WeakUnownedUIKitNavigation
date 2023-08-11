//
//  StateObjectExampleCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

final class StateObjectExampleCoordinator: NSObject, Coordinator {
    let id: UUID
    
    unowned private let navigationController: UINavigationController
    
    weak private var featureEViewController: UIViewController?
    weak private var featureEViewModel: FeatureEViewModel?
    
    weak private var featureFViewController: UIViewController?
    
    weak private var featureGViewController: UIViewController?
    weak private var featureGViewModel: FeatureGViewModel?
    
    weak private var featureHViewController: UIViewController?
    weak private var featureHViewModel: FeatureHViewModel?
    
    init(
        id: UUID = UUID(),
        navigationController: UINavigationController = NavigationController()
    ) {
        self.id = id
        self.navigationController = navigationController
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    func showRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? StateObjectExampleRoute {
            return showStateObjectExampleRoute(route)
        }
        return false
    }
    
    func canPopToRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? StateObjectExampleRoute {
            return canPopToStateObjectExampleRoute(route)
        }
        return false
    }
    
    func popToRoute(_ route: NavigationRoute) -> Bool {
        if let route = route as? StateObjectExampleRoute {
            return popToStateObjectExampleRoute(route)
        }
        return false
    }
    
    func popToRootViewController(animated: Bool) -> Bool {
        navigationController.popToRootViewController(animated: animated)
        return true
    }
    
    private func showStateObjectExampleRoute(_ route: StateObjectExampleRoute) -> Bool {
        switch route {
        case .FeatureE:
            guard featureEViewController == nil else { return false }
            
            let viewModel = FeatureEViewModel(coordinator: self)
            featureEViewModel = viewModel
            
            let view = FeatureEView(featureEViewModel: viewModel)
            let viewController = HostingController(rootView: view)
            featureEViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
            
            return self.showRoute(StateObjectExampleRoute.FeatureF)
        case .FeatureF:
            guard featureFViewController == nil else { return false }
            
            guard let featureEViewModel else { return false }
            
            let view = FeatureFView(featureEViewModel: featureEViewModel)
            let viewController = HostingController(rootView: view)
            featureFViewController = viewController
            
            guard let sheetController = viewController.sheetPresentationController else { return false }
            sheetController.detents = [.medium(), .large()]
            sheetController.largestUndimmedDetentIdentifier = .medium
            
            // bug: class object will not deinit
//            sheetController.prefersGrabberVisible = true
            
            sheetController.delegate = self
            
            navigationController.present(viewController, animated: true)
            
            guard let navigationController = navigationController as? NavigationController else { return false }
            
            navigationController.willPopHandler = { navigationController.dismiss(animated: false) }
            
            return true
        case .FeatureG:
            guard featureGViewController == nil else { return false }
            
            let viewModel = FeatureGViewModel(coordinator: self)
            featureGViewModel = viewModel
            
            let view = FeatureGView(featureGViewModel: viewModel)
            let viewController = HostingController(rootView: view)
            featureGViewController = viewController
            
            if featureFViewController != nil { navigationController.dismiss(animated: true) }
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        case .FeatureH:
            guard featureHViewController == nil else { return false }
            
            let viewModel = FeatureHViewModel(coordinator: self)
            featureHViewModel = viewModel
            
            let view = FeatureHView(featureHViewModel: viewModel)
            let viewController = HostingController(rootView: view)
            featureHViewController = viewController
            
            navigationController.pushViewController(viewController, animated: true)
            
            return true
        }
    }
    
    private func canPopToStateObjectExampleRoute(_ route: StateObjectExampleRoute) -> Bool {
        switch route {
        case .FeatureE:
            if featureEViewController == nil { return false }
        case .FeatureF: return false
        case .FeatureG:
            if featureGViewController == nil { return false }
        case .FeatureH:
            if featureHViewController == nil { return false }
        }
        return true
    }
    
    private func popToStateObjectExampleRoute(_ route: StateObjectExampleRoute) -> Bool {
        switch route {
        case .FeatureE:
            guard let featureEViewController else { return false }
            navigationController.popToViewController(featureEViewController, animated: true)
        case .FeatureF: return false
        case .FeatureG:
            guard let featureGViewController else { return false }
            navigationController.popToViewController(featureGViewController, animated: true)
        case .FeatureH:
            guard let featureHViewController else { return false }
            navigationController.popToViewController(featureHViewController, animated: true)
        }
        
        return true
    }
}

extension StateObjectExampleCoordinator: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        navigationController.popViewController(animated: true)
    }
}
