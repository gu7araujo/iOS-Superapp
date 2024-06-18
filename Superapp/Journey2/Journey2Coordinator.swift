//
//  Journey2Coordinator.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 14/06/24.
//

import Foundation
import UIKit
import Core

class Journey2Coordinator: CoordinatorProtocol {
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var navigationController: UINavigationController
    var childCoordinators: [any CoordinatorProtocol] = []
    var childControllers: [UIViewController] = []
    var parentCoordinator: (any CoordinatorProtocol)?
    var type: CoordinatorType = .journey2
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(Journey2Coordinator.self) deinit")
    }
    
    func start() {
        let viewController = SecondViewController()
        navigationController.pushViewController(viewController, animated: true)
        childControllers.append(viewController)
    }
}
