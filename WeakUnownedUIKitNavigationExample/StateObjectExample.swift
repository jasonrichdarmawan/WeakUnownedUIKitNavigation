//
//  StateObjectExample.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 04/08/23.
//

import SwiftUI

struct FeatureFView: ViewControllable {
    var holder: NavStackHolder
    
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(holder: NavStackHolder = NavStackHolder(), featureEViewModel: FeatureEViewModel = FeatureEViewModel()) {
        self.holder = holder
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
    
    // use @ObservedObject instead of @StateObject
    @ObservedObject var featureEViewModel: FeatureEViewModel
    
    init(holder: NavStackHolder = NavStackHolder(), featureEViewModel: FeatureEViewModel = FeatureEViewModel()) {
        self.holder = holder
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
        let view = FeatureFView(featureEViewModel: featureEViewModel)
        
        let viewControllerToPresent = view.viewController
        
        if let sheetController = viewControllerToPresent.sheetPresentationController {
            sheetController.detents = [.medium(), .large()]
        }
        
        viewController.navigationController?.present(viewControllerToPresent, animated: true)
    }
}
