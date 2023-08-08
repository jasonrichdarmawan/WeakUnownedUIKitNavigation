//
//  ViewControllable.swift
//  WeakUnownedUIKitNavigationExample
//
//  Created by Jason Rich Darmawan Onggo Putra on 08/08/23.
//

import SwiftUI

protocol ViewControllable: View {
    func viewWillAppear(_ viewController: UIViewController)
    func viewDidAppear(_ viewController: UIViewController)
    func viewWillDisappear(_ viewController: UIViewController)
    func viewDidDisappear(_ viewController: UIViewController)
}

extension ViewControllable {
    func viewWillAppear(_ viewController: UIViewController) {}
    func viewDidAppear(_ viewController: UIViewController) {}
    func viewWillDisappear(_ viewController: UIViewController) {}
    func viewDidDisappear(_ viewController: UIViewController) {}
}
