//
//  ViewControllable.swift
//  WeakUnownedExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 02/08/23.
//

import SwiftUI

final class NavStackHolder {
    let id: UUID
    
    // try to remove weak
    // then navigate: to a page -> go back
    // the NavStack holder will not deinit.
    weak var viewController: UIViewController?
    
    init(id: UUID = UUID()) {
        self.id = id
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    
    deinit {
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
}

protocol ViewControllable: View {
    var holder: NavStackHolder { get set }
    
    func viewWillAppear(_ viewController: UIViewController)
    func viewDidAppear(_ viewController: UIViewController)
}

extension ViewControllable {
    var viewController: UIViewController {
        let viewController = HostingController(rootView: self)
        self.holder.viewController = viewController
        return viewController
    }
    
    func viewWillAppear(_ viewController: UIViewController) {}
    func viewDidAppear(_ viewController: UIViewController) {}
}

final class HostingController<ContentView>: UIHostingController<ContentView> where ContentView: ViewControllable {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.viewWillAppear(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rootView.viewDidAppear(self)
    }
}
