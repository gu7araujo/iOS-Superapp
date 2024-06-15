//
//  Journey4Coordinator.swift
//  Superapp
//
//  Created by Gustavo Araujo Santos on 15/06/24.
//

import Foundation
import UIKit

class Journey4Coordinator: CoordinatorProtocol {
    
    weak var finishDelegate: (any CoordinatorFinishDelegate)?
    var navigationController: UINavigationController
    var childCoordinators: [any CoordinatorProtocol] = []
    var childControllers: [UIViewController] = []
    var parentCoordinator: (any CoordinatorProtocol)?
    var type: CoordinatorType = .journey4
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(Journey4Coordinator.self) deinit")
    }
    
    func start() {
        let viewModel = Journey4ViewModel()
        viewModel.delegate = self
        let viewController = Journey4ViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        childControllers.append(viewController)
    }
}

extension Journey4Coordinator: Journey4ViewModelDelegate {
    func finishJourney() {
        finish()
    }
}
