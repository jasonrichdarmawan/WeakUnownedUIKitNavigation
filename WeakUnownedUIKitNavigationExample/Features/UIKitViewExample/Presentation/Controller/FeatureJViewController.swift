//
//  FeatureJViewController.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 15/08/23.
//

import UIKit
import Combine

final class FeatureJViewController: UIViewController {
    private let id: UUID
    
    private var cancellables: Set<AnyCancellable>!
    
    private weak var featureIVM: FeatureIViewModel?
    
    init(id: UUID = UUID(), featureIVM: FeatureIViewModel) {
        self.id = id
        self.featureIVM = featureIVM
        
        super.init(nibName: nil, bundle: nil)
        
        setup()
        
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    
    required init?(coder: NSCoder) {
        id = UUID()
        
        super.init(coder: coder)
        
        setup()
        
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    private func setup() {
        view = FeatureJView(controller: self)
        
        cancellables = Set<AnyCancellable>()
        featureIVM?
            .$count
            .sink { [weak self] count in
                guard let view = self?.view as? FeatureJView else { return }
                
                _ = view.updateCountLabel(count: count)
            }
            .store(in: &cancellables)
    }
    
    func incrementCount() -> Bool {
        featureIVM?.count += 1
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
