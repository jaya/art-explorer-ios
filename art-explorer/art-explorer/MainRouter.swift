//
//  MainRouter.swift
//  art-explorer
//
//  Created by Pedro Freddi on 16/06/25.
//

import Foundation
import UIKit

protocol MainRouterLogic {
    func makeRoot( _ viewController: UIViewController, animated: Bool)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

class MainRouter {
    static let shared = MainRouter()
    let navigationController: UINavigationController

    private init() {
        self.navigationController = UINavigationController()
    }

    func makeRoot( _ viewController: UIViewController, animated: Bool = false) {
        navigationController.setViewControllers([viewController], animated: animated)
    }

    func push(_ viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
