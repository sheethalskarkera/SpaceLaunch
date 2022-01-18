//
//  AppCoordinator.swift
//  SpaceLaunch
//
//  Created by Sheethal Karkera on 17/1/22.
//

import UIKit
final class AppCoordinator {
    private weak var window: UIWindow?
    private let navigationController: UINavigationController

    init(window: UIWindow?) {
        self.window = window
        navigationController = UINavigationController()
    }

    func setRootView() {
        if let window = window {
            let spaceLaunchHomeViewController = UIStoryboard.spaceLaunchHomeViewController
            navigationController.viewControllers = [spaceLaunchHomeViewController]
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    
}
