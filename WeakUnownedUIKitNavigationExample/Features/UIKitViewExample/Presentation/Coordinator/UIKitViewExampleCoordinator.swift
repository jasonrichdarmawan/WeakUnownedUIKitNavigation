//
//  UIKitViewExampleCoordinator.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 15/08/23.
//

import UIKit

final class UIKitViewExampleCoordinator: NSObject, Coordinator {
    private let id: UUID

    private unowned let navigationController: UINavigationController

    private weak var featureIVM: FeatureIViewModel?
    private weak var featureIVC: UIViewController?
    
    private weak var featureJVC: UIViewController?

    init(id: UUID = UUID(), navigationController: UINavigationController) {
        self.id = id
        self.navigationController = navigationController
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }

    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }

    func showRoute(_ route: NavigationRoute) -> Bool {
        guard let route = route as? UIKitViewExampleRoute else { return false }
        return showUIKitViewExampleRoute(route)
    }

    private func showUIKitViewExampleRoute(_ route: UIKitViewExampleRoute) -> Bool {
        switch route {
        case .FeatureI:
            let viewModel = FeatureIViewModel(coordinator: self)
            featureIVM = viewModel
            
            let view = FeatureIView(featureIVM: viewModel)
            let viewController = HostingController(rootView: view)
            featureIVC = viewController

            navigationController.pushViewController(viewController, animated: true)

            return showUIKitViewExampleRoute(UIKitViewExampleRoute.FeatureJ)
        case .FeatureJ:
            let viewController = FeatureJViewController(featureIVM: featureIVM)
            featureJVC = viewController
            
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
        }
    }
}

extension UIKitViewExampleCoordinator: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        navigationController.popViewController(animated: true)
    }
}
