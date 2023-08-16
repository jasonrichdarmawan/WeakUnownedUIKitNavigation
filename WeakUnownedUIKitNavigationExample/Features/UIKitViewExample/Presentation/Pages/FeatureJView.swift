//
//  FeatureJView.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 15/08/23.
//

import UIKit

final class FeatureJView: UIView {
    private let id: UUID
    
    private unowned var controller: UIViewController
    
    private var label: UILabel!
    private var countLabel: UILabel!
    private var incrementButton: UIButton!
    
    init(id: UUID = UUID(), controller: UIViewController) {
        self.id = id
        self.controller = controller
        super.init(frame: .zero)
        
        setup()
        
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    
    required init?(coder: NSCoder) {
        id = UUID()
        let controller = FeatureJViewController()
        self.controller = controller
        
        super.init(coder: coder)
        
        setup()
        
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    private func setup() {
        backgroundColor = .systemBackground
        
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Feature J"
        addSubview(label)
        
        countLabel = UILabel()
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.text = "count: 0"
        addSubview(countLabel)
        
        incrementButton = UIButton(type: .system)
        incrementButton.translatesAutoresizingMaskIntoConstraints = false
        incrementButton.setTitle("increment", for: .normal)
        incrementButton.configuration = .borderedProminent()
        incrementButton.addTarget(self, action: #selector(incrementCount), for: .touchUpInside)
        addSubview(incrementButton)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            countLabel.topAnchor.constraint(equalTo: label.bottomAnchor),
            countLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            incrementButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor),
            incrementButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    func updateCountLabel(count: Int) -> Bool {
        countLabel.text = "count: \(count)"
        return true
    }
    
    @objc func incrementCount() {
        guard let controller = controller as? FeatureJViewController else { return }
        
        _ = controller.incrementCount()
    }
}
