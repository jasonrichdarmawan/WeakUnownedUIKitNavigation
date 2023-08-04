//
//  WeakExample.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

final class WeakExampleCoordinator {
    let id: UUID
    
    unowned let navigationController: UINavigationController
    
    unowned var publisher: Publisher?
    unowned var subscriber: Subscriber?
    
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
        let publisher = Publisher()
        
        let view = FeatureAView(coordinator: self, publisher: publisher)
        
        self.publisher = publisher
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
    
    func next() -> Bool {
        guard let publisher else { return false }
        
        let subscriber = Subscriber()
        
        publisher.subscriber = subscriber
        
        self.subscriber = subscriber
        
        let view = FeatureBView(coordinator: self, subscriber: subscriber)
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
    
    func popToRoot() -> Bool {
        navigationController.popToRootViewController(animated: true)
        
        return true
    }
}

class Subscriber {
    let id: UUID
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

class Publisher {
    let id: UUID
    
    // try to remove weak.
    // then navigate: Feature A -> Feature B -> go back.
    // subscriber object will not deinit
    weak var subscriber: Subscriber?
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
}

struct FeatureBView: ViewControllable {
    var holder: NavStackHolder
    
    let coordinator: WeakExampleCoordinator
    
    let subscriber: Subscriber
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: WeakExampleCoordinator = WeakExampleCoordinator(),
        subscriber: Subscriber = Subscriber()
    ) {
        self.holder = holder
        self.coordinator = coordinator
        self.subscriber = subscriber
    }
    
    var body: some View {
        VStack {
            Text("Feature B")
            Button {
                _ = coordinator.popToRoot()
            } label: {
                Text("Pop to root")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct FeatureAView: ViewControllable {
    var holder: NavStackHolder
    
    let coordinator: WeakExampleCoordinator
    
    let publisher: Publisher
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        coordinator: WeakExampleCoordinator = WeakExampleCoordinator(),
        publisher: Publisher = Publisher()
    ) {
        self.holder = holder
        self.coordinator = coordinator
        self.publisher = publisher
    }
    
    var body: some View {
        VStack {
            Text("Feature A")
            
            Button {
                _ = coordinator.next()
            } label: {
                Text("Feature B")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
