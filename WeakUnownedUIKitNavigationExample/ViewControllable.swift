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
    func viewWillDisappear(_ viewController: UIViewController)
    func viewDidDisappear(_ viewController: UIViewController)
}

extension ViewControllable {
    var viewController: UIViewController {
        let viewController = HostingController(rootView: self)
        self.holder.viewController = viewController
        return viewController
    }
    
    func viewWillAppear(_ viewController: UIViewController) {}
    func viewDidAppear(_ viewController: UIViewController) {}
    func viewWillDisappear(_ viewController: UIViewController) {}
    func viewDidDisappear(_ viewController: UIViewController) {}
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        rootView.viewWillDisappear(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        rootView.viewDidDisappear(self)
    }
}

final class NavigationController: UINavigationController {
    let id: UUID = UUID()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("\(type(of: self)) \(#function) \(id.uuidString)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit { print("\(type(of: self)) \(#function) \(id.uuidString)") }
    
    var willPopHandler: (() -> Bool)?
    
    override func popViewController(animated: Bool) -> UIViewController? {
        _ = willPopHandler?()
        willPopHandler = nil
        return super.popViewController(animated: animated)
    }
}
