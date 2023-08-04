//
//  StateObjectExample.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 04/08/23.
//

import SwiftUI

final class StateObjectExampleCoordinator: NSObject {
    let id: UUID
    
    unowned let navigationController: UINavigationController
    unowned var featureEViewModel: FeatureEViewModel?
    
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
        let featureEViewModel = FeatureEViewModel()
        let view = FeatureEView(coordinator: self, featureEViewModel: featureEViewModel)
        self.featureEViewModel = featureEViewModel
        navigationController.pushViewController(view.viewController, animated: true)
        
        // dismiss then pop.
        guard let navigationController = navigationController as? NavigationController else { return false }
        navigationController.willPopHandler = { self.dismiss(animated: false) }
        
        return true
    }
    
    func present() -> Bool {
        guard let featureEViewModel else { return false }
        
        let view = FeatureFView(coordinator: self, featureEViewModel: featureEViewModel)
        
        let viewControllerToPresent = view.viewController
        
        guard let sheetController = viewControllerToPresent.sheetPresentationController else { return false }
        
        sheetController.detents = [.medium(), .large()]
        sheetController.largestUndimmedDetentIdentifier = .medium
        
        // bug: class object will not deinit
//        sheetController.prefersGrabberVisible = true
        
        sheetController.delegate = self
        
        navigationController.present(viewControllerToPresent, animated: true)
        
        return true
    }
    
    func dismiss(animated: Bool) -> Bool {
        navigationController.dismiss(animated: animated)
        
        return true
    }
}

extension StateObjectExampleCoordinator: UISheetPresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        navigationController.popViewController(animated: true)
    }
}

struct FeatureFView: ViewControllable {
    var holder: NavStackHolder
    
    let coordinator: StateObjectExampleCoordinator
    
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: StateObjectExampleCoordinator = StateObjectExampleCoordinator(),
        featureEViewModel: FeatureEViewModel = FeatureEViewModel()
    ) {
        self.holder = holder
        self.coordinator = coordinator
        self.featureEViewModel = featureEViewModel
    }
    
    var body: some View {
        VStack {
            Text("Feature F")
            Text("count \(featureEViewModel.count)")
            Button {
                featureEViewModel.count += 1
            } label: {
                Text("increment")
            }
        }
    }
}

final class FeatureEViewModel: ObservableObject {
    let id: UUID
    
    @Published var count: Int
    
    init(id: UUID = UUID(), count: Int = 0) {
        self.id = id
        self.count = count
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

struct FeatureEView: ViewControllable {
    var holder: NavStackHolder
    
    let coordinator: StateObjectExampleCoordinator
    
    // use @ObservedObject instead of @StateObject
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: StateObjectExampleCoordinator = StateObjectExampleCoordinator(),
        featureEViewModel: FeatureEViewModel = FeatureEViewModel()
    ) {
        self.holder = holder
        self.coordinator = coordinator
        self.featureEViewModel = featureEViewModel
    }
    
    var body: some View {
        VStack {
            Text("Feature E")
            Text("count \(featureEViewModel.count)")
            Button {
                featureEViewModel.count += 1
            } label: {
                Text("increment")
            }
            
            Spacer()
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func viewDidAppear(_ viewController: UIViewController) {
        _ = coordinator.present()
    }
}
