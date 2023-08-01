//
//  WeakExample.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

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
    
    let subscriber: Subscriber
    
    init(
        holder: NavStackHolder = NavStackHolder(),
        publisher: Publisher = Publisher(),
        subscriber: Subscriber = Subscriber()
    ) {
        self.holder = holder
        self.subscriber = subscriber
        publisher.subscriber = subscriber
    }
    
    var body: some View {
        Text("Feature B")
    }
}

struct FeatureAView: ViewControllable {
    var holder: NavStackHolder
    
    let publisher: Publisher
    
    init(holder: NavStackHolder = NavStackHolder(), publisher: Publisher = Publisher()) {
        self.holder = holder
        self.publisher = publisher
    }
    
    var body: some View {
        VStack {
            Text("Feature A")
            
            Button {
                _ = navigateToFeatureB()
            } label: {
                Text("Feature B")
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    func viewWillAppear(_ viewController: UIViewController) {
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func navigateToFeatureB() -> Bool {
        guard let navigationController = holder.viewController?.navigationController else { return false }
        
        let view = FeatureBView(publisher: publisher)
        
        navigationController.pushViewController(view.viewController, animated: true)
        
        return true
    }
}
